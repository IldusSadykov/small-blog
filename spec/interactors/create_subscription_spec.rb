require "rails_helper"

describe CreateSubscription do
  describe ".call" do
    let!(:current_user) { create :user, stripe_customer_id: stripe_subscription.customer }
    let!(:post) { create :post, :with_plan }

    let(:stripe_customer) { double :stripe_customer, subscriptions: double(:subscriptions) }
    let!(:stripe_subscription) do
      result = JSON.parse(
        File.read("spec/fixtures/stripe_subscription.json")
      )
      Stripe::StripeObject.construct_from(result)
    end
    let(:stripe_plan) { double :stripe_plan, id: "plan_stripe_id" }

    let!(:request_params) do
      {
        stripeToken: "stripeToken",
        stripeEmail: "stripeEmail"
      }
    end

    subject(:interactor) do
      described_class.call(
        current_user: current_user,
        params: request_params,
        plan: post.plan
      )
    end

    before do
      allow(Stripe::Customer).to receive(:retrieve).with(current_user.stripe_customer_id).and_return(stripe_customer)
      allow(stripe_customer.subscriptions).to receive(:create).and_return(stripe_subscription)
      allow(Stripe::Plan).to receive(:retrieve).and_return(stripe_plan)
    end

    context "when user customer exists" do
      it "does create subscription" do
        expect { interactor }.to change { current_user.subscriptions.count }.by(1)
        expect(current_user.subscriptions.last.stripe_id).to eq stripe_subscription.id
      end
    end
  end
end
