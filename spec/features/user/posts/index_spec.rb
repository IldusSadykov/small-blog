require "rails_helper"

feature "List of Posts" do
  include_context "current user signed in"

  let(:posts) { create_list :post, posts_count, user: current_user }
  let(:posts_count) { 3 }

  def posts_on_page
    all(".post-item")
  end

  scenario "Author shows own posts" do
    visit user_posts_path(current_user)

    expect(posts_on_page.count).to eq(posts_count)
  end
end
