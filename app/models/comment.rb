class Comment < ActiveRecord::Base
  validates :message, :post, :user, presence: true

  scope :created_at_order_desc, -> { order("created_at desc") }

  belongs_to :post, counter_cache: true
  belongs_to :user
end
