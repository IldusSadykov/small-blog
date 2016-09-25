FactoryGirl.define do
  factory :customer do
    stripe_id "MyString"
    account_balance 1.5
    created Time.now
    currency "5"
    description "MyString"
    email
    livemode false
  end

end
