class Post < ActiveRecord::Base
  validates :title, :body, :category, :user, presence: true

  belongs_to :user
  has_many :comments
end
