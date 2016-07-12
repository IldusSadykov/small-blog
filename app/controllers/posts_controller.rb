class PostsController < ApplicationController
  respond_to :html
  respond_to :js, only: :update

  expose_decorated(:post, attributes: :post_params)
  expose_decorated(:posts)

  expose(:categories) { Category.all }

  before_action :authorize_user?, only: %i(update destroy)
  before_action :check_user_subscription, except: :index

  def new
    respond_with post
  end

  def index
    self.posts = current_user.posts
    respond_with posts
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
    post.save
    respond_with post
  end

  def destroy
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
      ).merge(user: current_user)
  end

  def authorize_user?
    fail NotAuthorizedError unless AccessPolicy.new(post, current_user).can_manage?
  end

  def check_user_subscription
    fail NotAuthorizedError unless current_user.subscriptions.map(&:plan).include?(post.plan)
  end
end
