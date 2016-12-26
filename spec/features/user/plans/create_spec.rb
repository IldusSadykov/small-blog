require "rails_helper"
require "stripe_mock"

feature "Author create new plan" do
  include_context "current user signed in"

  let(:stripe_helper) { StripeMock.create_test_helper }

  before do
    StripeMock.start
    visit plans_path

    click_link "Add new plan"
  end

  after { StripeMock.stop }

  scenario "Author creates plan with valid params" do
    fill_form :plan, attributes_for(:plan).slice(:name, :amount)

    click_on submit(:plan)

    expect(page).to have_text("Plan was successfully created.")
  end

  scenario "Author creates plan with invalid params" do
    click_on submit(:plan)

    expect(page).to have_text("Namecan't be blank")
    expect(page).to have_text("Amountcan't be blank")
  end
end
