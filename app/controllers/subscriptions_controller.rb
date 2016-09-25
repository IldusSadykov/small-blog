class SubscriptionsController < ApplicationController
  expose(:post)

  def create
    CreateSubscription.call(current_user: current_user, post: post, params: params)

    redirect_to post_path(post)
  end
end
