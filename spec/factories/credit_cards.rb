FactoryGirl.define do
  factory :credit_card do
    stripe_id "MyString"
    brand "MyString"
    last4 "MyString"
    name "MyString"
    user
  end
end
