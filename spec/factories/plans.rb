FactoryGirl.define do
  factory :plan do
    name "MyPlan"
    amount 10
    created Time.zone.now
    currency "rub"
    stripe_id "MyStripe"
    interval "1"
    interval_count 1
    livemode false
    statement_descriptor "MyText"
    trial_period_days 5
    user
  end
end
