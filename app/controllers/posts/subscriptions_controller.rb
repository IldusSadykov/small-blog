module Posts
  class SubscriptionsController < ApplicationController
    expose(:post, finder_parametr: :post_id)

    def create
      CreateSubscription.call(
        current_user: current_user,
        plan: post.plan,
        params: params
      )

      redirect_to user_posts_path(current_user, subscribed: true)
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
end
