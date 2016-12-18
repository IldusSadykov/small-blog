require "rails_helper"

feature "Create new subscription", js: true do
  include_context "current user signed in"

  let!(:post) { create :post, :published, plan: plan }
  let!(:plan) { create :plan, stripe_id: stripe_plan.id }
  let(:stripe_customer) do
    double(
      :stripe_customer,
      id: "stripe_customer_id",
      subscriptions: double(:subscriptions),
      sources: double(:sources)
    )
  end
  let!(:stripe_subscription) do
    result = JSON.parse(
      File.read("spec/fixtures/stripe_subscription.json")
    )
    Stripe::StripeObject.construct_from(result)
  end
  let(:stripe_plan) { double :stripe_plan, id: stripe_subscription.plan.id }
  let!(:stripe_card) do
    result = JSON.parse(File.read("spec/fixtures/stripe_credit_card.json"))
    Stripe::StripeObject.construct_from(result)
  end

  before do
    current_user.update(stripe_customer_id: stripe_customer.id)
    allow(Stripe::Plan).to receive(:retrieve).and_return(stripe_plan)
    allow(Stripe::Customer).to receive(:retrieve).with(user.stripe_customer_id).and_return(stripe_customer)
    allow(stripe_customer.subscriptions).to receive(:create).and_return(stripe_subscription)
    allow(stripe_customer.sources).to receive(:create).and_return(stripe_card)
    allow(Stripe::Plan).to receive(:retrieve).and_return(stripe_plan)

    visit root_path
    click_button "Subscribe"
    wait_for_ajax
  end

  scenario "I am in new subcription popup" do
    within_frame "stripe_checkout_app" do
      expect(page).to have_content plan.name
    end
  end

  scenario "I can pay stripe" do
    pay_stripe

    find("span.label", text: "Subscribed", wait: 30)

    expect(current_path).to eq post_path(Post.first.id)
    expect(page).to have_content post.title
    expect(page).to have_content post.body
  end
end
