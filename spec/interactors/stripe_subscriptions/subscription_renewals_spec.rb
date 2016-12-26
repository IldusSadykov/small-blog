require "rails_helper"
require "stripe_mock"

describe StripeSubscriptions::SubscriptionRenewals do
  before { StripeMock.start }
  after { StripeMock.stop }

  describe ".call" do
    let(:event) { StripeMock.mock_webhook_event("invoice.payment_succeeded") }
    let(:stripe_subscription) { event.data.object.lines.data.last }
    let!(:user) { create :user, stripe_customer_id: event.data.object.customer }
    let!(:subscription) do
      create(
        :subscription,
        user: user,
        stripe_id: stripe_subscription.id,
        current_period_start: nil,
        current_period_end: nil
      )
    end

    subject(:interactor) { described_class.call(event: event) }

    it "does update subscription" do
      current_period_start = Time.zone.at(stripe_subscription.period.start)
      prev_period_start = subscription.current_period_start

      expect { interactor }.to change { subscription.reload.current_period_start }
        .from(prev_period_start).to(current_period_start)
    end
  end
end
