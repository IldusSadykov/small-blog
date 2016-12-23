require "rails_helper"
require "stripe_mock"

describe StripeSubscriptions::NotifyPaymentFailure do
  before { StripeMock.start }
  after { StripeMock.stop }

  describe ".call" do
    let(:event) { StripeMock.mock_webhook_event("invoice.payment_failed") }
    let!(:user) { create :user, stripe_customer_id: event.data.object.customer }

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
