require "rails_helper"

feature "Author create new post" do
  include_context "current user signed in"

  let!(:category) { create :category, name: "News" }

  before do
    visit user_posts_path(current_user)

    click_link "Add new post"
  end

  scenario "Author in new post page" do
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

  scenario "Author creates post with valid params" do
    fill_form :post, attributes_for(:post).slice(:title, :body, :category)

    click_on submit(:post)

    expect(page).to have_text("Post was successfully created.")
  end

  scenario "Author creates post with invalid params" do
    click_on submit(:post)

    expect(page).to have_text("Titlecan't be blank")
    expect(page).to have_text("Bodycan't be blank")
  end
end
