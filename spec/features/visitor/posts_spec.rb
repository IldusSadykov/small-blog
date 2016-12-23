require "rails_helper"

feature "Visitor sees post" do
  scenario "Visitor sees posts for given author" do
    user = create(:user)
    another_user = create(:user)

    first_post = create(:post, user: user)
    second_post = create(:post, :with_plan, user: user)
    third_post = create(:post, :with_plan, user: another_user)

    visit user_posts_path(user)

    expect(page).to have_text(first_post.title)
    expect(page).to have_text(second_post.title)

    expect(page).not_to have_text(third_post.title)
  end

  scenario "Visitor can see free post" do
    post = create(:post)

    visit post_path(post)

    expect(page).to have_text(post.title)
    expect(page).to have_text(post.body)
  end

  scenario "Visitor can't see non free post" do
    post = create(:post, :with_plan)

    visit post_path(post)

    expect(page).to have_content("Not allowed to access to this resource, please subscribe")
  end
end
