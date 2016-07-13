class DashboardController < ApplicationController
  respond_to :html

  expose_decorated(:posts, collection: true) { Post.all.includes(:user, :plan).limit(10) }
  expose(:categories) { Category.all }

  def index
    respond_with posts, categories
  end
end
