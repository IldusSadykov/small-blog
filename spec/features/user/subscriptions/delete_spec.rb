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

    stripe_subscription = stripe_customer.subscriptions.create(plan: stripe_plan.id)
    current_user.subscriptions.create(StripeSubscription.new(stripe_subscription).as_json)

    visit subscribed_posts_path

    wait_for_ajax
  end

  after { StripeMock.stop }

  scenario "Author can delete subscriptions" do
    click_link "Unsubscribe"

    text = page.driver.browser.switch_to.alert.text

    expect(text).to eq "Your subscription has been successfully deleted"
  end
end
