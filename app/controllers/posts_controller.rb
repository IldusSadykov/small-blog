class PostsController < ApplicationController
  respond_to :html
  respond_to :js, only: :update

  expose(:post, attributes: :post_params)
  expose(:user_posts) { current_user.posts }

  expose(:post_presenter) { PostPresenter.wrap(post) }
  expose(:posts_presenter) { PostPresenter.wrap(user_posts) }

  expose(:categories) { Category.all }

  before_action :authorize_user?, only: %i(update, destroy)

  def index
    respond_with posts_presenter
  end

  def show
    respond_with post_presenter
  end

  def create
    post.save
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
        :category_id
      ).merge(user: current_user)
  end

  def authorize_user?
    fail NotAuthorizedError unless AccessPolicy.new(post, current_user).can_manage?
  end
end
