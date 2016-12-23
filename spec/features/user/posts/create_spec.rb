require "rails_helper"

feature "Author create new post" do
  include_context "current user signed in"

  let!(:category) { create :category, name: "News" }

  before do
    visit user_posts_path(current_user)

    click_link "Add new post"
  end

  scenario "Author creates post with valid params" do
    fill_form :post, attributes_for(:post).slice(:title, :body)

    click_on submit(:post)

    expect(page).to have_text("Post was successfully created.")
  end

  scenario "Author creates post with invalid params" do
    click_on submit(:post)

    expect(page).to have_text("Titlecan't be blank")
    expect(page).to have_text("Bodycan't be blank")
  end
end
