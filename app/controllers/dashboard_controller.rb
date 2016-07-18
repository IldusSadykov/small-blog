class DashboardController < ApplicationController
  respond_to :html

  expose(:dashboard) { Dashboard.new(current_user, request.location) }

  def show
    respond_with dashboard
  end
end
