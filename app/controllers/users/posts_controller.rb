module Users
  class PostsController < ApplicationController
    respond_to :html

    expose(:user)
    expose_decorated(:posts) { user.posts.includes(:author) }

    def index
      respond_with posts
    end
  end
end
