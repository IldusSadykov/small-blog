class FetchCurrentLocation
  include Interactor

  delegate :current_user, :request_location, to: :context

  def call
    context.current_location = fetch_location
  end

  private

  def fetch_location
    @location ||= if coordinates_present?(request_location)
      request_location
    elsif current_user
      current_user.location
    else
      @result ||= Geocoder.search("Kazan")
      location_params = @result.first.data["geometry"]["location"]
      Location.new(location_params)
    end
  end

  def coordinates_present?(location)
    location.latitude.to_i > 0 && location.longitude.to_i > 0
  end
end
