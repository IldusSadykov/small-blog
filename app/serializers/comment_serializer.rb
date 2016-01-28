class CommentSerializer < ActiveModel::Serializer
  attributes :message, :author, :created_at

  def author
    object.user.full_name
  end

  def created_at
    object.created_at.strftime('%B %d, %Y at %I:%M%p')
  end
end
