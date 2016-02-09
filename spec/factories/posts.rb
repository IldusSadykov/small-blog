# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    title { Faker::Lorem.word }
    body  { Faker::Lorem.paragraph }
    association :user, factory: :user
    association :category, factory: :category
    published false
  end

  trait :published do
    published true
  end
end
