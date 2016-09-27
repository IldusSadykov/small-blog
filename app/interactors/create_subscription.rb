class CreateSubscription
  include Interactor

  delegate :current_user, :post, :params, to: :context
  delegate :plan, to: :post

  def call
    current_user.subscriptions.create(subscription_params(stripe_subscription))
  end

  private

  def stripe_subscription
    @subscription ||=
      Stripe::Subscription.create(
        customer: customer.stripe_id,
        plan: plan.stripe_id
      )
  end

  def subscription_params(entity)
    {
      stripe_id: entity.id,
      current_period_end: Time.at(entity.current_period_end),
      current_period_start: Time.at(entity.current_period_start),
      ended_at: entity.ended_at ? Time.at(entity.ended_at) : nil,
      start: Time.at(entity.start),
      status: entity.status,
      trial_end: entity.trial_end,
      trial_start: entity.trial_start,
      plan_id: plan.id
    }
  end

  def customer
    @customer ||= FetchORCreateCustomer.call(
      current_user: current_user,
      stripe_token: params[:stripeToken],
      stripe_email: params[:stripeEmail]
    )
  end
end
