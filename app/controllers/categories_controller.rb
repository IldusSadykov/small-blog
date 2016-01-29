class CategoriesController < ApplicationController
  expose(:category)
  expose_decorated(:posts, ancestor: :category)

  respond_to :html

  def show
    respond_with posts
  end
end
