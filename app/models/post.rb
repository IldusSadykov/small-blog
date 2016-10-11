class Post < ActiveRecord::Base
  validates :title, :body, :category, :author, presence: true

  belongs_to :author, foreign_key: "user_id", class_name: "User"
  has_many :comments
  belongs_to :category
  belongs_to :plan
  belongs_to :user
  has_many :comments, dependent: :destroy

  after_save    :expire_post_all_cache
  after_destroy :expire_post_all_cache

  def expire_post_all_cache
    Rails.cache.delete('Post.last(10)')
  end

  def self.all_cached
    Rails.cache.fetch('Post.last(10)') { Post.includes(:author, :plan).last(10) }
  end

  def subscribed?(user)
    plan && user && plan.subscription_users_ids.include?(user.id)
  end
end
