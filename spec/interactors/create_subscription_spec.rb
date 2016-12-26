require "rails_helper"

describe CreateSubscription do
  before { StripeMock.start }

  after { StripeMock.stop }

  describe ".call" do
    let(:stripe_helper) { StripeMock.create_test_helper }
    let(:stripe_plan) { stripe_helper.create_plan(id: "monthly", amount: 1500) }
    let(:plan) { create :plan, name: "my plan", stripe_id: stripe_plan.id }
    let(:stripe_customer) do
      Stripe::Customer.create(
        email: current_user.email,
        source: stripe_helper.generate_card_token
      )
    end

    let!(:post) { create :post, title: "post title", body: "post body", plan: plan }
    let!(:current_user) { create :user }
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
      current_user.update(stripe_customer_id: stripe_customer)

      allow(Stripe::Customer).to receive(:retrieve).with(current_user.stripe_customer_id).and_return(stripe_customer)
      allow(stripe_customer.sources).to receive(:create).and_return(stripe_customer.sources["data"].first)
    end

    context "when user customer exists" do
      it "does create subscription" do
        expect { interactor }.to change { current_user.subscriptions.count }.by(1)
      end
    end
  end
end
