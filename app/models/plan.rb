class Plan < ActiveRecord::Base
  belongs_to :user

  validates :name, :amount, :stripe_id, :currency, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
end
