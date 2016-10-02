module StripeSubscriptions
  class EventsProcessing
    include Interactor

    delegate :event_type, :event_object, to: :context

    EVENT_TYPES = {
      "invoice.payment_succeeded" => SubscriptionRenewals,
      "invoice.payment_failed" => NotifyPaymentFailure,
      "charge.failed" => NotifyPaymentFailure,
      "customer.subscription.updated" => SubscriptionUpdate,
      "customer.subscription.deleted" => SubscriptionUpdate
    }

    def call
      EVENT_TYPES[event_type].send(:call, event: event_object)
    end
  end
end
