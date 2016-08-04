class PostDecorator < ApplicationDecorator
  decorates_association :comments, scope: :created_at_order_desc

  delegate :id, :title, :body, :author, :plan, :subscribed?

  def author_name
    object.author.full_name
  end

  def build_comment
    object.comments.build
  end
end
