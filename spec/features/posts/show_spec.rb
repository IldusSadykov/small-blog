require "rails_helper"

feature "Show Posts" do
  let(:user) { create(:user) }
  let!(:post) { create(:post, user: user, title: "My Post") }

  before do
    login_as user

    visit post_path(post)
  end

  scenario "I should see New comment button" do
    expect(page).to have_content("New comment")
  end

  scenario "show my post" do
    expect(page).to have_content("My Post")
  end

  scenario "I can edit my post" do
    expect(page).to have_content("Edit")
  end
end
