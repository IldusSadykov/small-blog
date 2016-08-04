class DashboardController < ApplicationController
  respond_to :html

  expose(:dashboard) { Dashboard.new(current_location, current_user) }

  def show
    respond_with dashboard
  end
end
