class Plan < ActiveRecord::Base
  belongs_to :user
  has_many :subscriptions

  validates :name, :amount, :stripe_id, :currency, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 }

  def subscriptoin_users_ids
    subscriptions.active.pluck(:user_id).compact
  end
end
