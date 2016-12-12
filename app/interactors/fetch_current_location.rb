class FetchCurrentLocation
  include Interactor

  DEFAULT_CITY = "Kazan".freeze

  delegate :current_user, :request_location, to: :context

  def call
    context.current_location = fetch_location
  end

  private

  def fetch_location
    return request_location if coordinates_present?(request_location)
    return current_user.location if current_user.present? && current_user.location
    fetched_default_location
  end

  def coordinates_present?(location)
    location.latitude.to_i.nonzero? && location.longitude.to_i.nonzero?
  end

  def fetched_default_location
    @result ||= Geocoder.search(DEFAULT_CITY)
    location_params = @result.first.data["geometry"]["location"]
    Location.new(location_params)
  end
end
