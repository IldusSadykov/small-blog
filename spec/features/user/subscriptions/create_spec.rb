require "rails_helper"
require "stripe_mock"

feature "Create new subscription", js: true do
  include_context "current user signed in"

  let(:stripe_helper) { StripeMock.create_test_helper }

  before do
    StripeMock.start

    #current_user.update(stripe_customer_id: stripe_customer.id)
    stripe_plan = stripe_helper.create_plan(id: "monthly", amount: 1500)
    plan = create :plan, name: "my plan", stripe_id: stripe_plan.id
    create :post, :plan: plan

    visit root_path
    click_button "Subscribe"
    wait_for_ajax
  end

  after do
    StripeMock.stop
  end

  scenario "Author can pay stripe" do
    pay_stripe

    find("span.label", text: "Subscribed", wait: 30)

    expect(current_path).to eq post_path(Post.first.id)
    expect(page).to have_content post.title
    expect(page).to have_content post.body
  end
end
