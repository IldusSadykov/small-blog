class ApplicationController < ActionController::Base
  include Authentication
  include Authorization

  protect_from_forgery with: :exception

  responders :flash
  respond_to :html

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

  def current_location
    result = FetchCurrentLocation.call(current_user: current_user, request_location: request.location)
    result.current_location
  end

  helper_method :current_location
end
