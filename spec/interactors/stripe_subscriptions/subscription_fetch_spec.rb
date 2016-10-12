require "rails_helper"

describe StripeSubscriptions::SubscriptionFetch do
  describe ".call" do
    let!(:subscription) { create :subscription, user: user, stripe_id: "stripe_subscription_id" }

    subject(:interactor) do
      described_class.call(
        stripe_sub_id: "stripe_subscription_id",
        stripe_customer_id: "stripe_customer_id"
      )
    end

    context "when user customer exists" do
      let!(:user) { create :user, stripe_customer_id: "stripe_customer_id" }

      it "does fetch subscription" do
        expect(interactor.subscription).to eq subscription
      end
    end

    context "when user customer doesn't exist" do
      let!(:user) { create :user }

      it "does create stripe customer" do
        expect(interactor.subscription).to be_nil
      end
    end
  end
end
