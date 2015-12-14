class DashboardController < ApplicationController
  respond_to :html

  expose(:posts_presenter) { PostPresenter.wrap(Post.includes(:user).last(10)) }
  expose(:categories) { Category.all }

  def index
    respond_with posts_presenter, categories
  end
end
