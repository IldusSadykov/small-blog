class DeleteSubscription
  include Interactor

  delegate :current_user, :post, to: :context

  def call
    @subscription ||= Stripe::Subscription.retrieve(user_subscription.stripe_id)
    if @subscription
      @subscription.delete(at_period_end: true)
      user_subscription.update(subscription_params)
    else
      user_subscription.update(subscription_params)
      context.fail!(error: "Something went wrong, but your subscription has been successfully deleted")
    end
  end

  private

  def user_subscription
    @user_subscription ||= current_user.subscriptions.find_by(plan: post.plan)
  end

  def subscription_params
    {
      current_period_end: Time.current,
      ended_at: Time.current,
      canceled_at: Time.current,
      status: "canceled"
    }
  end
end
