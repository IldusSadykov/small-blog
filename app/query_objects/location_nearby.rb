class LocationNearby
  attr_reader :location, :distance

  def initialize(location, distance)
    @location = location
    @distance = distance
  end

  def all
    return Location.none if location.blank?
    Location.near([location[:latitude], location[:longitude]], distance)
  end
end
