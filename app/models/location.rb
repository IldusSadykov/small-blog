class Location < ActiveRecord::Base
  has_many :users
  belongs_to :country

  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.street_changed? }

  geocoded_by :address, latitude: :lat, longitude: :lon

  def address
    [street, city, state, country].compact.join(', ')
  end
end
