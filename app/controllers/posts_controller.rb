class PostsController < ApplicationController
  respond_to :html, :json

  expose_decorated(:post, attributes: :post_params)
  expose_decorated(:posts) { PostsWithQuery.new(params[:query]).all }

  expose(:categories) { Category.all }

  before_action :check_user_subscription, except: %i(new create index update)

  def new
    respond_with post
  end

  def index
    respond_with posts, each_serializer: PostSerializer
  end

  def show
    respond_with post
  end

  def create
    post.save
    respond_with post
  end

  def edit
    respond_with post
  end

  def update
    authorize post, :edit?
    post.save
    respond_with post
  end

  def destroy
    authorize post, :edit?
    post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params
      .require(:post)
      .permit(
        :title,
        :body,
        :picture,
        :published,
        :category_id,
        :plan_id
      ).merge(author: current_user)
  end

  def check_user_subscription
    authorize post, :subscribed_by_user
  end
end
