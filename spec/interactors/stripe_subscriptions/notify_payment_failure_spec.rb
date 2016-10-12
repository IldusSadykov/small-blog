require "rails_helper"

describe StripeSubscriptions::NotifyPaymentFailure do
  describe ".call" do
    let!(:user) { create :user, stripe_customer_id: event.customer }

    let!(:event) { double :event, customer: "stripe_customer_id" }
    let(:user_mailer) { double :user_mailer }

    subject(:interactor) { described_class.call(event: event) }

    before do
      allow(UserMailer).to receive(:payment_failed).and_return(user_mailer)
      allow(user_mailer).to receive(:deliver)
      interactor
    end

    it "does update subscription" do
      expect(UserMailer).to have_received(:payment_failed)
    end
  end
end
