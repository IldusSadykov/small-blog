class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :plan

  scope :active, -> { where("status = 'active' and current_period_end >= ?", Time.current) }
end
