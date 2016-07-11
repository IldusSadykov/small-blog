class Post < ActiveRecord::Base
  validates :title, :body, :category, :user, presence: true

  belongs_to :user
  has_many :comments
  belongs_to :category
  belongs_to :plan
  has_many :comments, dependent: :destroy
end
