class ApplicationController < ActionController::Base
  include Authentication
  include Authorization

  protect_from_forgery with: :exception

  responders :flash
  respond_to :html

  expose(:authors_coordinates) { AuthorsCoordinatesFetch.call(user: current_user).coordinates }

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end
end
