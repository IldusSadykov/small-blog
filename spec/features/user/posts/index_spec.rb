require "rails_helper"

feature "List of Posts" do
  include_context "current user signed in"

  context "author own posts" do
    let(:posts_count) { 3 }
    let!(:posts) { create_list :post, posts_count, user: current_user }

    def posts_on_page
      all(".blog-post")
    end

    scenario "Author shows own posts" do
      visit user_posts_path(current_user)

      expect(posts_on_page.count).to eq(posts_count)
    end
  end

  context "another user posts" do
    let(:free_posts_count) { 3 }
    let(:posts_count) { 2 }
    let(:another_user) { create :user }
    let!(:free_posts) { create_list :post, free_posts_count, user: another_user }
    let!(:posts) { create_list :post, posts_count, :with_plan, user: another_user }

    def posts_on_page
      all(".blog-post")
    end

    scenario "Author can see another user posts" do
      visit user_posts_path(another_user)

      expect(posts_on_page.count).to eq(posts_count + free_posts_count)
    end
  end
end
