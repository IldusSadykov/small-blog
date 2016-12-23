# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.sentences(20).join(" ") }
    user
    category
  end

  trait :with_plan do
    plan
  end
end
