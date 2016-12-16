# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment, class: "Comment" do
    message { Faker::Lorem.sentences }
    association :user, factory: :user
    association :post, factory: :post
  end
end
