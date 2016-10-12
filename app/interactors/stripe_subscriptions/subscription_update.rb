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
        stripe_sub_id: event.id,
        stripe_customer_id: event.customer
      ).subscription
    end

    def subscription_params
      StripeSubscription.new(event).as_json
    end
  end
end
