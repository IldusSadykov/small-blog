class ApplicationController < ActionController::Base
  include Authentication
  include Authorization

  protect_from_forgery with: :exception

  responders :flash
  respond_to :html

  expose(:authors_with_locations) { AuthorsWithCoordinatesFetch.call(user: current_user, current_location: request.location).users }

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end
end
