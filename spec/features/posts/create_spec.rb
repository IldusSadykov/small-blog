require "rails_helper"

feature "Create new post" do
  let(:user) { create :user }
  let!(:category) { create :category, name: "News" }

  before do
    login_as user

    visit user_posts_path(user)
    click_link "Add new post"
  end

  scenario "I am in new post page" do
    expect(current_path).to eq new_post_path
    expect(page).to have_css("form.new_post")
    expect(page).to have_css("input#post_title")
    expect(page).to have_css("textarea#post_body")
    expect(page).to have_css("input#post_published")
  end

  def fill_form(title = "", body = "")
    within("form.new_post") do
      fill_in "Title", with: title
      fill_in "Body", with: body
      select category.name, from: "post[category_id]"
    end
  end

  scenario "I fill form with valid data" do
    fill_form("Test title", "Test text")

    click_button "Create Post"

    expect(current_path).to eq post_path(Post.first.id)
    expect(page).to have_content "Test title"
    expect(page).to have_content "Test text"
  end

  scenario "I fill form with invalid data" do
    fill_form

    click_button "Create Post"

    expect(page).to have_css ".alert-box"
    expect(page).to have_css ".error"

    within(".alert-box") do
      expect(page).to have_content "Post could not be created."
    end

    within(".post_title") do
      expect(page).to have_content "can't be blank"
    end

    within(".post_body") do
      expect(page).to have_content "can't be blank"
    end
  end
end
