module StripeSubscriptions
  class NotifyPaymentFailure
    include Interactor

    delegate :event, to: :context

    def call
      UserMailer.payment_failed(user.id, message).deliver
    end

    private

    def user
      @user ||= User.find_by(stripe_customer_id: event.data.object.customer)
    end

    def message
      I18n.t("stripe.payment.failed")
    end
  end
end
