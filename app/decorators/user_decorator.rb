class UserDecorator < ApplicationDecorator
  delegate :id, :full_name, :email

  def full_name_with_email
    "#{object.full_name} (#{object.email})"
  end

  def lat
    object.location.lat
  end

  def lng
    object.location.lon
  end
end
