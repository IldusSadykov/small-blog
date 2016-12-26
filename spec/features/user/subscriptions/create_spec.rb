require "rails_helper"
require "stripe_mock"

feature "Create new subscription", js: true do
  include_context "current user signed in"

  let(:stripe_helper) { StripeMock.create_test_helper }
  let(:stripe_customer) do
    Stripe::Customer.create(
      email: current_user.email,
      source: stripe_helper.generate_card_token
    )
  end
  let(:post_title) { "post title" }
  let(:post_body) { "post body" }

  before do
    StripeMock.start

    stripe_plan = stripe_helper.create_plan(id: "monthly", amount: 1500)

    current_user.update(stripe_customer_id: stripe_customer.id)
    allow(Stripe::Customer).to receive(:retrieve).with(current_user.stripe_customer_id).and_return(stripe_customer)
    allow(stripe_customer.sources).to receive(:create).and_return(stripe_customer.sources["data"].first)

    plan = create :plan, name: "my plan", stripe_id: stripe_plan.id
    create :post, title: post_title, body: post_body, plan: plan

    visit root_path

    click_button "Subscribe"

    wait_for_ajax
  end

  after { StripeMock.stop }

  def subscribe_result_message
    find("a.delete-subscription", text: "Unsubscribe", wait: 5)
  end

  def card_error_popup
    find(".Popover-content", wait: 5)
  end

  scenario "Author can pay stripe with valid card" do
    pay_stripe("4242424242424242")

    expect(subscribe_result_message).to have_content "Unsubscribe"

    expect(current_path).to eq post_path(Post.first.id)
    expect(page).to have_content post_title
    expect(page).to have_content post_body
  end

  scenario "Author can't pay stripe with declined card" do
    pay_stripe("4000000000000002")

    within_frame "stripe_checkout_app" do
      expect(card_error_popup).to have_content "This card was declined."
    end
  end
end
