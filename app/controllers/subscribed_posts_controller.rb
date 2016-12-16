class SubscribedPostsController < ApplicationController
  respond_to :html, :json

  expose(:post, finder_parametr: :post_id)
  expose_decorated(:posts) { current_user.subscribed_posts }

  def index
    respond_with posts, each_serializer: PostSerializer
  end

  def destroy
    authorize post, :subscribed?

    result = DeleteSubscription.call(current_user: current_user, post: post)
    if result.success?
      render json: { message: "Your subscription has been successfully deleted" }, status: :ok, location: nil
    else
      render json: { error: result.error }, status: :unprocessible_entity, location: nil
    end
  end
end
