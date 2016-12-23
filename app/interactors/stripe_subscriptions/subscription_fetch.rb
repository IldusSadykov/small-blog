module StripeSubscriptions
  class SubscriptionFetch
    include Interactor

    delegate :stripe_sub_id, :stripe_customer_id, to: :context

    def call
      context.subscription = user&.subscriptions&.unscoped.find_by(stripe_id: stripe_sub_id)
    end

    private

    def user
      @user ||= User.find_by(stripe_customer_id: stripe_customer_id)
    end
  end
end
