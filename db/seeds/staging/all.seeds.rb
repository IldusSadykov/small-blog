users = FactoryGirl.create_list(:user, 20)
categories = %w(News Code Design Fun Weasels).reduce([]) do |categories, title|
  categories << FactoryGirl.create(:category, name: title)
end
100.times do
  post = FactoryGirl.create(:post, user: users.sample, category: categories.sample)
  10.times do
    FactoryGirl.create(:comment, post: post, user: users.sample)
  end
end
[{name: "Russia", code: "RU"}, {name: "USA", code: "US"}].each do |country_params|
  FactoryGirl.create(:country, country_params)
end
