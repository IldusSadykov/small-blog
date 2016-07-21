class CommentDecorator < ApplicationDecorator
  delegate :id, :message

  def user_name
    object.user.full_name
  end
end
