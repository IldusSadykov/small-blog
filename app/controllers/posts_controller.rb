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
  end

  def show
    self.post = PostUserDecorator.new([post, current_user])
    authorize post, :read?

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
end
