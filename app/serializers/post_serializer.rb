class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :user_with_location, :created_at

  def created_at
    object.created_at.strftime('%B %d, %Y at %I:%M%p')
  end

  def user_with_location
    {
      id: object.user_id,
      name: object.user_name,
      location: {
        lat: object.user_lat,
        lng: object.user_lng
      }
    }
  end
end
