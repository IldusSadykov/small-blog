class UsersNearby
  attr_reader :location

  def initialize(location)
    @location = location
  end

  def all
    return Location.none if location.blank?
    Location.joins(:user)
      .near([location.latitude, location.longitude], 10)
      .select("users.full_name as user_name, users.id as user_id")
  end
end
