module Users
  class PostsController < ApplicationController
    respond_to :html

    expose(:user)
    expose_decorated(:posts) { fetch_posts }

    def index
      respond_with posts
    end

    private

    def fetch_posts
      if params[:subscribed]
        current_user.subscribed_posts
      else
        user.posts.includes(:author)
      end
    end
  end
end
