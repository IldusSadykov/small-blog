class Posts::SubscriptionsController < ApplicationController
  expose(:post, finder_parametr: :post_id)

  def create
    CreateSubscription.call(
      current_user: current_user,
      plan: post.plan,
      params: params
    )

    redirect_to post_path(post)
  end
end
