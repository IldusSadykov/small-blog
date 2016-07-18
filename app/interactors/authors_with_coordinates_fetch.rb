class AuthorsWithCoordinatesFetch
  include Interactor

  delegate :user, :current_location, to: :context

  def call
    context.users = users_with_locations.map do |uwl|
      user_params(uwl)
    end
  end

  private

  def users_with_locations
    location = coordinates_present?(current_location) ? current_location : user.location
    UsersNearby.new(location).all
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

  def coordinates_present?(location)
    location.latitude.to_i > 0 && location.longitude.to_i > 0
  end
end
