class PostDecorator < ApplicationDecorator
  decorates_association :comments, scope: :created_at_order_desc

  delegate :id, :title, :body, :user, :plan

  def published?
    object.published
  end

  def author
    object.user.full_name
  end

  def build_comment
    object.comments.build
  end
end
