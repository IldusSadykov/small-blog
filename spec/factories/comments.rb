# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    message { Faker::Lorem.sentence }
    association :user, factory: :user
    association :post, factory: :post
  end
end
