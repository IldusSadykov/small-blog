class CommentsController < ApplicationController
  expose(:post)
  expose(:comment, attributes: :comment_params)
  expose(:comments, ancestor: :post)

  respond_to :html
  respond_to :json

  def create
    comment.user = current_user
    comment.post = post
    comment.save
    respond_with comment, location: nil, root: false
  end

  def edit
  end

  def destroy
    comment.destroy
    respond_with comment, location: post_path(post)
  end

  private

  def comment_params
    params.require(:comment).permit(:message)
  end
end
