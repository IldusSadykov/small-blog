class LocationSerializer < ActiveModel::Serializer
  attributes :id, :street, :city, :state, :latitude, :longitude, :created_at

  def created_at
    object.created_at.strftime('%B %d, %Y at %I:%M%p')
  end
end
