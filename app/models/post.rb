class Post < ActiveRecord::Base
  validates :title, :body, :category, :user, presence: true

  belongs_to :user
  has_many :comments
  belongs_to :category
  has_many :comments, dependent: :destroy

  def published?
    published
  end
end
