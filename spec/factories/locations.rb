FactoryGirl.define do
  factory :location do
    street "MyString"
    city "MyString"
    state "MyString"
    association :country, factory: :country
    latitude 1.5
    longitude 1.5
  end
end
