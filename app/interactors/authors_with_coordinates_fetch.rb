class AuthorsWithCoordinatesFetch
  include Interactor

  delegate :user, to: :context

  def call
    context.coordinates = users_with_locations.map do |uwl|
      user_params(uwl)
    end
  end

  private

  def users_with_locations
    UsersNearby.new(user).all
  end

  def user_params(entity)
    {
      id: entity.user_id,
      name: entity.user_name,
      location: {
        lat: entity.lat,
        lng: entity.lon,
      }
    }
  end
end
