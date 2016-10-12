require "rails_helper"

feature "Edit posts" do
  let(:user) { create(:user) }
  let(:another_user) { create(:user, :not_confirmed) }
  let!(:category) { create :category, name: "News" }

  let!(:post) do
    create(
      :post,
      user: user,
      title: "My post",
      body: "test body",
      category: category
    )
  end

  let!(:another_post) do
    create(
      :post,
      user: another_user,
      title: "Another user post",
      body: "another test body",
      category: category
    )
  end

  before do
    login_as user

    visit user_posts_path(user)
  end

  def fill_form(title = "", body = "")
    fill_in "Title", with: title
    fill_in "Body", with: body
  end

  scenario "I fill form with valid data" do
    click_link "Edit post"

    fill_form("New test title", "New test body")

    select category.name, from: "post[category_id]"

    click_button "Update Post"

    expect(page).to have_content("New test title")
  end

  scenario "I fill form with invalid data" do
    click_link "Edit post"

    fill_form

    click_button "Update Post"

    within(".alert-box") do
      expect(page).to have_content("Post could not be updated.")
    end

    within(".post_title") do
      expect(page).to have_content "can't be blank"
    end

    within(".post_body") do
      expect(page).to have_content "can't be blank"
    end
  end
end
