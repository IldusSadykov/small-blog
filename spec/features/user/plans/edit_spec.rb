require "rails_helper"
require "stripe_mock"

feature "Author create new plan" do
  include_context "current user signed in"

  let(:stripe_helper) { StripeMock.create_test_helper }
  let(:plan_name) { "Monthly plan" }
  let(:plan) { create :plan, name: plan_name, user: current_user, stripe_id: stripe_plan.id }
  let(:stripe_plan) { stripe_helper.create_plan(id: "monthly", amount: 1500) }

  before do
    StripeMock.start
    visit plan_path(plan)
  end

  after { StripeMock.stop }

  scenario "Author updates plan" do
    expect(page).to have_text(plan_name)

    click_link "Edit plan"

    refill_form_and_submit

    expect(page).to have_text("Plan was successfully updated.")
    expect(page).to have_text("Updated name")
    expect(page).to have_text("55")
  end

  def refill_form_and_submit
    fill_in "Name", with: "Updated name"
    fill_in "Amount", with: "55"
    click_on submit(:plan, :update)
  end
end
