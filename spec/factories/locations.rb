FactoryGirl.define do
  factory :location do
    street "MyString"
    city "MyString"
    state "MyString"
    association :country, factory: :country
    lat 1.5
    lon 1.5
  end
end
