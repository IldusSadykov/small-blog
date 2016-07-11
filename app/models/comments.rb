class Comment < ActiveRecord::Base
  validates :message, :post, :user, presence: true

  belongs_to :post
end