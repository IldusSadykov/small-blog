require "rails_helper"
require "stripe_mock"

feature "Delete subscription", js: true do
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
  let(:plan) { create :plan, name: "my plan" }
  let!(:post) { create :post, title: post_title, body: post_body, plan: plan }

  before do
    StripeMock.start

    stripe_plan = stripe_helper.create_plan(id: "monthly", amount: 1500)
    plan.update(stripe_id: stripe_plan.id)
    stripe_subscription = stripe_customer.subscriptions.create(plan: plan.stripe_id)
    current_user.update(stripe_customer_id: stripe_customer.id)
    current_user.subscriptions.create(StripeSubscription.new(stripe_subscription).as_json)

    allow(Stripe::Customer).to receive(:retrieve).with(current_user.stripe_customer_id).and_return(stripe_customer)
    allow(stripe_customer.sources).to receive(:create).and_return(stripe_customer.sources["data"].first)

    visit user_posts_path(current_user, subscribed: true)
  end

  after { StripeMock.stop }

  def unsubscribe_link
    find(:id, "post_#{post.id}").find(:css, "a.delete-subscription")
  end

  scenario "Author can delete subscriptions" do
    unsubscribe_link.click

    sleep 2

    expect(alert_box_text("notice")).to have_content "Your subscription has been successfully deleted"
  end
end
