FactoryGirl.define do
  factory :subscription do
    cancel_at_period_end false
    canceled_at nil
    created Time.zone.now
    current_period_end Time.zone.now + 1.week
    current_period_start Time.zone.now
    ended_at 1.month.from_now
    livemode false
    quantity 1
    start Time.zone.now
    status "active"
    trial_end nil
    trial_start nil
    association :plan, factory: :plan
  end
end
