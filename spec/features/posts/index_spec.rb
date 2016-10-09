require "rails_helper"

feature "List of current_user posts" do
  let(:user) { create(:user) }
  let(:another_user) { create(:user, :not_confirmed) }

  let!(:post) { create(:post, user: user, title: "My Post 1") }
  let!(:published_post) { create(:post, :published, user: user, title: "My Post 2") }
  let!(:another_post) do
    create(
      :post,
      user: another_user,
      title: "Another user post 1",
      body: "another test body"
    )
  end

  let!(:published_another_post) do
    create(
      :post,
      :published,
      user: another_user,
      title: "Another user post 2",
      body: "another test body"
    )
  end

  before do
    login_as user

    visit posts_path
  end

  scenario "I am in index page" do
    expect(current_path).to eq posts_path
    expect(page).to have_content("My Post 1")
  end

  scenario "I should see my posts in index page" do
    expect(page).to have_content("My Post 1")
    expect(page).to have_content("My Post 2")
  end

  scenario "I should not see another user posts in index page" do
    expect(page).not_to have_content("Another user post 1")
    expect(page).not_to have_content("Another user post 2")
  end
end
