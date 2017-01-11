require "rails_helper"

feature "Delete Posts" do
  include_context "current user signed in"

  let(:post_title) { "post title" }
  let(:post_body) { "post body" }

  let!(:post) do
    create(
      :post,
      user: current_user,
      title: post_title,
      body: post_body
    )
  end

  scenario "Author delete own post" do
    visit post_path(post)

    click_on "Delete post"

    expect(page).to_not have_text(post_title)
    expect(page).to_not have_text(post_body)
  end
end
