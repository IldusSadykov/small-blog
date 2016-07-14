class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :user_name, :user_lat, :user_lng, :created_at

  def created_at
    object.created_at.strftime('%B %d, %Y at %I:%M%p')
  end
end
