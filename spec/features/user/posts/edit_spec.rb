require "rails_helper"

feature "Edit posts" do
  include_context "current user signed in"

  let!(:post) do
    create(
      :post,
      user: current_user,
      title: "My post",
      body: "Test body"
    )
  end

  before { visit post_path(post) }

  scenario "Author updates article" do
    expect(page).to have_text("My post")
    expect(page).to have_text("Test body")

    click_on "Edit post"

    refill_form_and_submit

    expect(page).to have_text("Post was successfully updated.")
    expect(page).to have_text("Updated title")
    expect(page).to have_text("Updated body")
  end

  def refill_form_and_submit
    fill_in "Title", with: "Updated title"
    fill_in "Body", with: "Updated body"
    click_on submit(:post, :update)
  end
end
