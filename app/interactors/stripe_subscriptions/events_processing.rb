module StripeSubscriptions
  class EventsProcessing
    include Interactor

    delegate :event, to: :context

    EVENT_TYPES = {
      "invoice.payment_succeeded" => SubscriptionRenewals,
      "invoice.payment_failed" => NotifyPaymentFailure,
      "charge.failed" => NotifyPaymentFailure,
      "customer.subscription.updated" => SubscriptionUpdate,
      "customer.subscription.deleted" => SubscriptionUpdate
    }.freeze

    def call
      EVENT_TYPES[event.type].send(:call, event: event)
    end
  end
end
