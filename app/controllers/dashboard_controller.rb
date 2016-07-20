class DashboardController < ApplicationController
  respond_to :html

  expose(:dashboard) { Dashboard.new(current_location) }

  def show
    respond_with dashboard
  end
end
