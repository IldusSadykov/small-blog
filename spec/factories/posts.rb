# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    title "MyString"
    body "MyText"
    user nil
    association :category, factory: :category
    published false
  end

  trait :published do
    published true
  end
end
