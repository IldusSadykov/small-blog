require "rails_helper"

feature "Visitor sees post" do
  scenario "Visitor sees posts for given author" do
    user = create(:user)
    another_user = create(:user)

    post_1 = create(:post, user: user)
    post_2 = create(:post, :with_plan, user: user)
    post_3 = create(:post, :with_plan, user: another_user)

    visit user_posts_path(user)

    expect(page).to have_text(post_1.title)
    expect(page).to have_text(post_2.title)

    expect(page).not_to have_text(post_3.title)
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
