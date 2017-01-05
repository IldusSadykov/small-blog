require "rails_helper"
require "stripe_mock"

describe StripeSubscriptions::NotifyPaymentFailure do
  before { StripeMock.start }
  after { StripeMock.stop }

  describe ".call" do
    let(:event) { StripeMock.mock_webhook_event("invoice.payment_failed") }
    let(:user_mailer) { double :user_mailer }
    let!(:user) { create :user, stripe_customer_id: event.data.object.customer }

    subject(:interactor) { described_class.call(event: event) }

    it "sends payment failed email to user" do
      interactor
      open_email(user.email)

      expect(current_email).to have_subject("Your most recent invoice payment failed")
      expect(current_email).to have_body_text(user.full_name)
    end
  end
end
