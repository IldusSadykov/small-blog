class Post < ActiveRecord::Base
  include PgSearch

  validates :title, :body, :author, presence: true

  belongs_to :author, foreign_key: "user_id", class_name: "User"
  has_many :comments
  belongs_to :category
  belongs_to :plan
  belongs_to :user
  has_many :comments, dependent: :destroy

  pg_search_scope :search_full_text,
    against: {
      title: "A",
      body: "A"
    },
    using: { tsearch: { prefix: true } }

  def subscribed?(user)
    plan && user && plan.subscription_users_ids.include?(user.id)
  end
end
