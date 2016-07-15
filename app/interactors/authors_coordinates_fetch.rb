class AuthorsCoordinatesFetch
  include Interactor

  delegate :user, to: :context

  def call
    context.coordinates = locations.reduce([]) do |address, location|
      address.push user_params(location)
    end
  end

  private

  def locations
    UsersNearby.new(user).all
  end

  def user_params(location)
    {
      user_lat: location.lat,
      user_lng: location.lon,
      user_name: location.user_name,
      user_id: location.user_id
    }
  end
end
