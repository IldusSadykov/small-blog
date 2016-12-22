class PostsController < ApplicationController
  respond_to :html
  respond_to :json, only: :index

  expose_decorated(:post, attributes: :post_params)

  expose(:categories) { Category.all }

  def new
    respond_with post
  end

  def index
    posts = PostsWithQuery.new(params[:query]).all
    respond_with posts, each_serializer: PostSerializer

    fresh_when(last_modified: posts.maximum(:updated_at))
  end

  def show
    authorize post, :read?

    respond_with post
  end

  def create
    post.author = current_user
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
        :category_id,
        :plan_id
    )
  end
end
