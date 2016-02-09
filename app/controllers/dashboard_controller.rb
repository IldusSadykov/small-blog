class DashboardController < ApplicationController
  respond_to :html

  expose_decorated(:posts, collection: true)
  expose(:categories) { Category.all }

  def index
    self.posts = posts.includes(:user)
    respond_with posts, categories
  end
end
