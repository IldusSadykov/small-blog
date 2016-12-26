require "rails_helper"

feature "Create comment to existing post", js: true do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user, title: "My Post") }
  let(:test_message) { "Test message" }

  before do
    login_as user

    visit post_path(post)
  end

  scenario "User creates new comment with valid params" do
    click_button "New comment"

    fill_form :comment, message: test_message

    click_on submit(:comment)

    expect(page).to have_content(test_message)
  end
end
