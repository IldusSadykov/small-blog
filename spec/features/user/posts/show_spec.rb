require "rails_helper"

feature "Show Posts" do
  include_context "current user signed in"

  let(:post_title) { "My post" }
  let(:post_body) { "post body" }

  let!(:post) do
    create(
      :post,
      user: current_user,
      title: post_title,
      body: post_body
    )
  end

  scenario "Author shows own post" do
    visit post_path(post)

    expect(page).to have_text(post_title)
    expect(page).to have_text(post_body)
  end

  scenario "Author can't see non free post" do
    post = create(:post, :with_plan)

    visit post_path(post)

    expect(page).to have_content("Not allowed to access to this resource, please subscribe")
  end

  scenario "Author can see other user post" do
    post = create(:post)

    visit post_path(post)

    expect(page).to have_content(post.title)
  end
end
