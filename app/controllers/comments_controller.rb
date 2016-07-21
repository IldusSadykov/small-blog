class CommentsController < ApplicationController
  expose(:post)
  expose(:comment, attributes: :comment_params)
  expose(:comments, ancestor: :post)

  respond_to :html
  respond_to :json, only: :create

  def create
    comment.save
    respond_with comment, location: nil, root: false
  end

  def edit
  end

  def update
    comment.save
    respond_with comment, location: post_path(post)
  end

  def destroy
    comment.destroy
    respond_with comment, location: post_path(post)
  end

  private

  def comment_params
    params
      .require(:comment)
      .permit(
        :message,
        :post_id
      ).merge(user: current_user, post: post)
  end
end
