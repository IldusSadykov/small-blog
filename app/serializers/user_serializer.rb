class UserSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :created_at

  has_one :location

  def created_at
    object.created_at.strftime('%B %d, %Y at %I:%M%p')
  end
end
