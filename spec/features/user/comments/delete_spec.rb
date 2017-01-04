require "rails_helper"

feature "Delete comment to existing post", js: true do
  include_context "current user signed in"

  let(:user) { create(:user) }
  let!(:user_post) { create(:post, user: user, title: "My Post") }
  let!(:comment) { create(:comment, post: user_post, user: current_user, message: "Test message") }

  before do
    visit post_path(user_post)
  end

  def delete_link
    find(:id, "comment_#{comment.id}").find(:css, "a.delete-comment")
  end

  scenario "User delete comment" do
    delete_link.click

    expect(alert_box_text("notice")).to have_content "Your comment has been successfully deleted"
  end
end
