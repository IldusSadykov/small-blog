class CommentDecorator < ApplicationDecorator
  delegate :id, :message

  def author
    object.user.full_name
  end

end
