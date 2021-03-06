class FetchCurrentLocation
  include Interactor

  DEFAULT_CITY = "Kazan".freeze

  delegate :current_user, :request_location, to: :context

  def call
    context.current_location = fetch_location
  end

  private

  def fetch_location
    return parsed_location(request_location) if request_location && coordinates_present?(request_location)
    return parsed_location(current_user.location) if current_user.present? && current_user.location
    parsed_location(fetched_default_location)
  end

  def coordinates_present?(location)
    location.latitude.to_i.nonzero? && location.longitude.to_i.nonzero?
  end

  def fetched_default_location
    result = Geocoder.search(DEFAULT_CITY)
    Location.new(location_params(result.first)) if result.first
  end

  def location_params(result)
    {
      latitude: result.data["geometry"]["location"]["lat"],
      longitude: result.data["geometry"]["location"]["lng"],
      city: result.data["address_components"].first["long_name"]
    }
  end

  def parsed_location(location)
    {
      latitude: location.latitude,
      longitude: location.longitude,
      city: location.city
    }
  end
end
