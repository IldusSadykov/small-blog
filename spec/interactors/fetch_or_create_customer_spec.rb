require "rails_helper"

describe FetchORCreateCustomer do
  describe ".call" do
    let!(:post) { create :post, :with_plan }

    let(:stripe_customer) { double :stripe_customer, id: "customer_stripe_id", sources:  stripe_credit_cards }
    let(:stripe_credit_cards) { double :credit_cards, data: [stripe_credit_card] }
    let!(:stripe_subscription) do
      result = JSON.parse(
        File.read("spec/fixtures/stripe_subscription.json")
      )
      Stripe::StripeObject.construct_from(result)
    end
    let!(:stripe_credit_card) do
      result = JSON.parse(File.read("spec/fixtures/stripe_credit_card.json"))
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

    context "when user customer exists" do
      let!(:current_user) { create :user, stripe_customer_id: stripe_customer.id }

      before do
        allow(Stripe::Customer).to receive(:retrieve)
          .with(current_user.stripe_customer_id).and_return(stripe_customer)
        allow(stripe_customer.sources).to receive(:create).and_return(stripe_credit_card)
      end

      it "does fetch customer" do
        expect(interactor.customer).to eq stripe_customer
      end

      it "does create credit card" do
        expect { interactor }.to change { current_user.credit_cards.count }.by(1)
      end
    end

    context "when user customer doesn't exist" do
      let!(:current_user) { create :user }

      before do
        allow(Stripe::Customer).to receive(:create).and_return(stripe_customer)
      end

      it "does create stripe customer" do
        expect(interactor.customer).to eq stripe_customer
      end

      it "does create credit card" do
        expect { interactor }.to change { current_user.credit_cards.count }.by(1)
      end
    end
  end
end
