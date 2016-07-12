class Users::PostsController < ApplicationController
  respond_to :html
  respond_to :js, only: :update

  expose(:user)
  expose_decorated(:post, attributes: :post_params)
  expose_decorated(:posts, ancestor: :user)

  expose(:categories) { Category.all }

  def index
    respond_with posts
  end
end
