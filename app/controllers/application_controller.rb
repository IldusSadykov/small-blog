class ApplicationController < ActionController::Base
  include Authentication
  include Authorization

  protect_from_forgery with: :exception

  responders :flash
  respond_to :html

  expose(:authors_coordinates) do
    locations =  Location.joins(:users).near('Kazan', 10).select("users.full_name as user_name, users.id as user_id")
    locations.reduce([]) do |address, location|
      address.push({
        lat: location.lat,
        lng: location.lon,
        user_name: location.user_name,
        user_posts: user_posts_path(location.user_id)
      })
    end
  end

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end
end
