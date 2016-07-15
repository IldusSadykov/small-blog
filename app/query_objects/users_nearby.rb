class UsersNearby
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def all
    return Location.none if user.blank?
    Location.joins(:users)
      .near(user.city, 10)
      .select("users.full_name as user_name, users.id as user_id")
  end
end
