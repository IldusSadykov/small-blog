module StripeSubscriptions
  class SubscriptionRenewals
    include Interactor

    delegate :event, to: :context

    def call
      event.paid && subscription&.update(subscription_params)
    end

    private

    def subscription
      @subscription ||= SubscriptionFetch.call(
        stripe_sub_id: stripe_subscription.id,
        stripe_customer_id: event.customer).subscription
    end

    def subscription_params
      event = Stripe::StripeObject.construct_from(
        id: stripe_subscription.id,
        current_period_start: stripe_subscription.period.start,
        current_period_end: stripe_subscription.period.end
      )
      StripeSubscription.new(event).as_json(
        only: %i(
          stripe_id
          current_period_start
          current_period_end
        )
      )
    end

    def stripe_subscription
      event.lines.data[0]
    end
  end
end
