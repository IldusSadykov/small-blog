require "rails_helper"

describe StripeSubscriptions::SubscriptionRenewals do
  describe ".call" do
    let!(:user) { create :user }
    let!(:subscription) do
      create(
        :subscription,
        user: user,
        stripe_id: stripe_subscription.id,
        current_period_start: nil,
        current_period_end: nil
      )
    end

    let!(:event_response) do
      result = JSON.parse(
        File.read("spec/fixtures/webhooks/payment_succeeded.json")
      )
      Stripe::StripeObject.construct_from(result)
    end

    let!(:event) { event_response.data.object }
    let!(:stripe_subscription) { event.lines.data[0] }
    let(:fetched_subscription) { double :fetched_subscription, subscription: subscription }

    subject(:interactor) { described_class.call(event: event) }

    before do
      allow(StripeSubscriptions::SubscriptionFetch).to receive(:call).and_return(fetched_subscription)
    end

    it "does update subscription" do
      current_period_start = Time.zone.at(stripe_subscription.period.start)
      interactor
      expect(subscription.current_period_start).to eq current_period_start
    end
  end
end
