users = FactoryGirl.create_list(:user, 10)
categories = %w(News Code Design Fun Weasels).reduce([]) do |categories, title|
  categories << FactoryGirl.create(:category)
end
100.times do
  post = FactoryGirl.create(:post, user: users.sample, category: categories.sample)
  FactoryGirl.create_list(:comment, 10, post: post, user: users.sample)
end
[{name: "Russia", code: "RU"}, {name: "USA", code: "US"}].each do |country_params|
  FactoryGirl.create(:country, country_params)
end
