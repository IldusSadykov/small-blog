module StripeSubscriptions
  class SubscriptionRenewals
    include Interactor

    delegate :event, to: :context

    def call
      event.data.object.paid && subscription&.update(subscription_params)
    end

    private

    def subscription
      @subscription ||= SubscriptionFetch.call(
        stripe_sub_id: stripe_subscription.id,
        stripe_customer_id: event.data.object.customer
      ).subscription
    end

    def subscription_params
      StripeSubscription.new(builded_event).as_json(
        only: %i(
          stripe_id
          current_period_start
          current_period_end
        )
      )
    end

    def stripe_subscription
      event.data.object.lines.data.last
    end

    def builded_event
      @builded_event ||= Stripe::StripeObject.construct_from(
        id: stripe_subscription.id,
        current_period_start: stripe_subscription.period.start,
        current_period_end: stripe_subscription.period.end
      )
    end
  end
end
