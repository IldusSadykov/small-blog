FactoryGirl.define do
  factory :subscription do
    cancel_at_period_end false
    canceled_at nil
    created Time.now
    current_period_end Time.now + 1.week
    current_period_start Time.now
    ended_at 1.month.from_now
    livemode false
    quantity 1
    start Time.now
    status "active"
    trial_end nil
    trial_start nil
    association :plan, factory: :plan
  end
end
