class Post < ActiveRecord::Base
  validates :title, :body, :category, :user, presence: true

  belongs_to :user
  belongs_to :category
  has_many :comments, dependent: :destroy
end
