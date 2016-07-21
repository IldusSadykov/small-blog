class CommentSerializer < ActiveModel::Serializer
  attributes :message, :user_name, :created_at

  def user_name
    object.user.full_name
  end

  def created_at
    object.created_at.strftime('%B %d, %Y at %I:%M%p')
  end
end
