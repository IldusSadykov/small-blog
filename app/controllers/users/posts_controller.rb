module Users
  class PostsController < ApplicationController
    respond_to :html

    expose(:user)
    expose_decorated(:posts) { fetch_posts.includes(:author, :plan) }

    def index
      respond_with posts
    end

    private

    def fetch_posts
      params[:subscribed] ? user.subscribed_posts : user.posts
    end
  end
end
