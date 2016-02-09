#FactoryGirl.create(:user, email: "user@example.com")

5.times.each do
  FactoryGirl.create(:user)
end

%w(News Code Design Fun Weasels).each do |name|
  FactoryGirl.create(:category, name: name)
end

50.times.each do
  post = FactoryGirl.create(:post, user: User.all.sample, category: Category.all.sample, published: [true, false].sample)
  10.times.each do
    FactoryGirl.create(:comment, user: User.all.sample, post: post)
  end
end
