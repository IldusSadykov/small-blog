require "rails_helper"

feature "Edit posts" do
  include_context "current user signed in"

  let(:post_title) { "My post" }
  let(:post_body) { "Test body" }
  let(:new_post_title) { "Updated title" }
  let(:new_post_body) { "Updated body" }

  let!(:post) do
    create(
      :post,
      user: current_user,
      title: post_title,
      body: post_body
    )
  end

  before { visit post_path(post) }

  scenario "Author updates post" do
    expect(page).to have_text(post_title)
    expect(page).to have_text(post_body)

    click_on "Edit post"

    refill_form_and_submit

    expect(page).to have_text("Post was successfully updated.")
    expect(page).to have_text(new_post_title)
    expect(page).to have_text(new_post_body)
  end

  def refill_form_and_submit
    fill_in "Title", with: new_post_title
    fill_in "Body", with: new_post_body
    click_on submit(:post, :update)
  end
end
