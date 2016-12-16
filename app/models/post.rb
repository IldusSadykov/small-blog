class Post < ActiveRecord::Base
  validates :title, :body, :category, :author, presence: true

  belongs_to :author, foreign_key: "user_id", class_name: "User"
  has_many :comments
  belongs_to :category
  belongs_to :plan
  belongs_to :user
  has_many :comments, dependent: :destroy

  def subscribed?(user)
    plan && user && plan.subscription_users_ids.include?(user.id)
  end
end
