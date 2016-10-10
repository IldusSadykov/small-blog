class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :trackable, :validatable

  validates :full_name, presence: true

  belongs_to :location
  has_many :posts, -> { includes :plan }
  has_many :plans
  has_many :subscriptions, -> { includes :plan }
  has_many :subscription_plans, through: :subscriptions, source: "plan"
  has_many :credit_cards

  accepts_nested_attributes_for :location

  def to_s
    full_name
  end

  def full_name_with_email
    "#{self[:full_name]} (#{email})"
  end

  def subscribed?(plan)
    plan = subscription_plans.find_by(id: plan.id) && plan.active?
  end
end
