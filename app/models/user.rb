class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :trackable, :validatable

  validates :full_name, presence: true

  belongs_to :location
  belongs_to :customer
  has_many :posts
  has_many :plans
  has_many :subscriptions, through: :customer

  accepts_nested_attributes_for :location

  delegate :city, :lat, :lon, to: :location, allow_nil: true

  def to_s
    full_name
  end

  def full_name_with_email
    "#{self[:full_name]} (#{email})"
  end
end
