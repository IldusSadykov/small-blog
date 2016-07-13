class DashboardController < ApplicationController
  respond_to :html

  expose_decorated(:posts, collection: true) { Post.all_cached }
  expose(:categories) { Category.all }

  def index
    respond_with posts, categories
  end
end
