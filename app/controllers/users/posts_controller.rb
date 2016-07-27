class Users::PostsController < ApplicationController
  respond_to :html

  expose(:user)
  expose_decorated(:post, attributes: :post_params)
  expose_decorated(:posts) { user.posts.includes(:author) }

  expose(:categories) { Category.all }

  def index
    respond_with posts
  end
end
