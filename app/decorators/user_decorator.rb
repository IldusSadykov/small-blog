class UserDecorator < ApplicationDecorator
  delegate :id, :full_name, :email

  def full_name_with_email
    "#{object.full_name} (#{object.email})"
  end

  def lat
    if object.location
      object.location.lat
    else
      Location::DEFAULT_LOCATION[:lat]
    end
  end

  def lng
    if object.location
      object.location.lon
    else
      Location::DEFAULT_LOCATION[:lng]
    end
  end
end
