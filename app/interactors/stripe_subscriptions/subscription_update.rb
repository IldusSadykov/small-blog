module StripeSubscriptions
  class SubscriptionUpdate
    include Interactor

    delegate :event, to: :context

    def call
      subscription&.update(subscription_params)
    end

    private

    def subscription
      @subscription ||= SubscriptionFetch.call(
        stripe_sub_id: stripe_subscription.id,
        stripe_customer_id: event.data.object.customer
      ).subscription
    end

    def stripe_subscription
      event.data.object
    end

    def subscription_params
      StripeSubscription.new(stripe_subscription).as_json
    end
  end
end
