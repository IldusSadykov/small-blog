require "rails_helper"

feature "Delete comment to existing post", js: true do
  include_context "current user signed in"

  let(:user) { create(:user) }
  let!(:user_post) { create(:post, user: user, title: "My Post") }
  let!(:comment) { create(:comment, post: user_post, user: current_user, message: "Test message") }

  before do
    visit post_path(user_post)
  end

  scenario "User delete comment" do
    click_link "Delete"

    text = page.driver.browser.switch_to.alert.text
    expect(text).to eq "Success delete comment!"
  end
end
