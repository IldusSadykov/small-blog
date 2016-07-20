class Location < ActiveRecord::Base
  has_one :user
  belongs_to :country

  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.street_changed? }

  alias_attribute :lat, :latitude
  alias_attribute :lng, :longitude

  geocoded_by :address

  def address
    [street, city, state, country].compact.join(', ')
  end
end
