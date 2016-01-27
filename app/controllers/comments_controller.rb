class CommentsController < ApplicationController
  expose(:post)
  expose(:comment, attributes: :comment_params)
  expose(:comments, ancestor: :post)

  private

  def comment_params
    params
      .require(:comment)
      .permit(
        :user_id,
        :message,
        :post_id
      ).merge(user: current_user, post: post)
  end
end
