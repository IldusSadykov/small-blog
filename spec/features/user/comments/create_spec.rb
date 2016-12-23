require "rails_helper"

feature "Create comment to existing post", js: true do
  include_context "current user signed in"

  let(:user) { create(:user) }
  let!(:user_post) { create(:post, user: user, title: "My Post") }

  before do
    visit post_path(user_post)
  end

  scenario "User creates new comment with valid params" do
    click_button "New comment"

    fill_form :comment, message: "Test message"

    click_on submit(:comment)

    expect(page).to have_text("Test message")
  end
end
