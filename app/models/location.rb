class Location < ActiveRecord::Base
  has_one :user
  belongs_to :country

  DEFAULT_LOCATION = {
    lat: 55.8304307,
    lng: 49.06608060000001
  }

  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.street_changed? }

  alias_attribute :latitude, :lat
  alias_attribute :longitude, :lon

  geocoded_by :address, latitude: :lat, longitude: :lon

  def address
    [street, city, state, country].compact.join(', ')
  end
end
