require "rails_helper"

feature "Show Posts" do
  include_context "current user signed in"

  let(:another_user) { create(:user, :not_confirmed) }

  let!(:post) do
    create(
      :post,
      user: current_user,
      title: "My post",
      body: "test body"
    )
  end

  let!(:another_post) do
    create(
      :post,
      :published,
      user: another_user,
      title: "Another user post",
      body: "another test body"
    )
  end

  scenario "Author shows own posts" do
    visit user_posts_path(current_user)

    expect(page).to have_text(post.title)
    expect(page).not_to have_text(another_post.title)
  end

  scenario "Author shows own post" do
    visit post_path(post)

    expect(page).to have_text(post.title)
    expect(page).to have_text(post.body)
  end
end
