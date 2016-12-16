class CommentSerializer < ActiveModel::Serializer
  attributes :id, :message, :user_name, :created_at, :comment_path

  def comment_path
    post_comment_path(object.post, object)
  end

  def user_name
    object.user.full_name
  end

  def created_at
    object.created_at.strftime("%B %d, %Y at %I:%M%p")
  end
end
