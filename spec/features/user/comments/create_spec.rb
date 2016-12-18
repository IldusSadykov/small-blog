require "rails_helper"

feature "Create comment to existing post", js: true do
  let(:user) { create(:user) }
  let!(:post) { create(:post, user: user, title: "My Post") }

  before do
    login_as user

    visit post_path(post)
  end

  def fill_form(message = "")
    within("form#new_comment") do
      fill_in "comment_message", with: message
      click_button "Create Comment"
    end
  end

  scenario "I should see New comment button" do
    within(".comments-form") do
      expect(page).to have_content("Comments")
      expect(page).to have_content("New comment")
    end
  end

  scenario "I can create valid comment" do
    click_button "New comment"

    fill_form("Test message")

    expect(page).to have_content("Test message")
  end
end
