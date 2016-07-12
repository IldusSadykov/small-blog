class SubscriptionsController < ApplicationController

  def create
    if user.customer
      stripe_subscription = Stripe::Subscription.create(
        customer: user.customer.stripe_id,
        plan: plan.stripe_id
      )
      user.customer.subscriptions.create(subscription_params(stripe_subscription))
    else
      stripe_customer = Stripe::Customer.create(
        source: params[:stripeToken],
        plan: plan.stripe_id,
        email: params[:stripeEmail]
      )
      customer = Customer.create(customer_params(stripe_customer))
      user.update(customer: customer)
      stripe_subscription = stripe_customer.subscriptions.data.first
      customer.subscriptions.create(subscription_params(stripe_subscription))
    end
    redirect_to post_path(post)
  end

  private

  def user
    User.find(params[:subscription][:user_id])
  end

  def plan
    Plan.find(params[:subscription][:plan_id])
  end

  def customer_params(entity)
    {
      stripe_id: entity.id,
      account_balance: entity.account_balance,
      created: Time.at(entity.created),
      currency: entity.currency,
      description: entity.description,
      email: entity.email,
      livemode: entity.livemode
    }
  end

  def subscription_params(entity)
    {
      stripe_id: entity.id,
      cancel_at_period_end: entity.cancel_at_period_end,
      canceled_at: entity.canceled_at ? Time.at(entity.canceled_at) : nil,
      created: Time.at(entity.created),
      current_period_end: Time.at(entity.current_period_end),
      current_period_start: Time.at(entity.current_period_start),
      ended_at: entity.ended_at ? Time.at(entity.ended_at) : nil,
      livemode: entity.livemode,
      quantity: entity.quantity,
      start: Time.at(entity.start),
      status: entity.status,
      trial_end: entity.trial_end,
      trial_start: entity.trial_start,
      plan_id: plan.id
    }
  end

  def post
    Post.find(params[:subscription][:post_id])
  end
end
