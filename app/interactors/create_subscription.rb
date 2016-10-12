class CreateSubscription
  include Interactor

  delegate :current_user, :params, :plan, to: :context
  delegate :stripe_id, to: :plan, prefix: true

  def call
    stripe_subscription = stripe_customer.subscriptions.create(plan: stripe_plan.id)
    current_user.subscriptions.create(subscription_params(stripe_subscription))
  end

  private

  def stripe_plan
    @stripe_plan ||= Stripe::Plan.retrieve(plan.stripe_id)
  end

  def stripe_customer
    @customer ||= FetchORCreateCustomer.call(
      current_user: current_user,
      stripe_token: params[:stripeToken],
      stripe_email: params[:stripeEmail]
    ).customer
  end

  def subscription_params(stripe_subscription)
    StripeSubscription.new(stripe_subscription).as_json
  end
end
