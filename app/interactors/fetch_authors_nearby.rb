class FetchAuthorsNearby
  include Interactor

  delegate :user, :current_location, to: :context

  def call
    context.authors = locations.includes(:user).map(&:user)
  end

  private

  def locations
    LocationNearby.new(location, Location::DEFAULT_DISTANCE).all
  end

  def location
    if coordinates_present?(current_location)
      current_location
    elsif user
      user.location
    else
      Location.none
    end
  end

  def coordinates_present?(location)
    location.latitude.to_i > 0 && location.longitude.to_i > 0
  end
end
