class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :created_at

  has_one :author

  def created_at
    object.created_at.strftime("%B %d, %Y at %I:%M%p")
  end
end
