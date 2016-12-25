require "rails_helper"

describe CustomerCreateCard do
  before { StripeMock.start }

  after { StripeMock.stop }

  describe ".call" do
    let(:stripe_helper) { StripeMock.create_test_helper }

    let!(:current_user) { create :user }
    let(:card_token) { stripe_helper.generate_card_token }

    let(:stripe_customer) do
      Stripe::Customer.create(
        email: current_user.email,
        source: card_token
      )
    end

    subject(:interactor) do
      described_class.call(
        current_user: current_user,
        stripe_customer: stripe_customer,
        stripe_token: card_token
      )
    end

    before do
      current_user.update(stripe_customer_id: stripe_customer)

      allow(Stripe::Customer).to receive(:retrieve).with(current_user.stripe_customer_id).and_return(stripe_customer)
      allow(stripe_customer.sources).to receive(:create).and_return(stripe_customer.sources["data"].first)
    end

    context "with stripe customer and stripe token are exists" do
      it "does create card" do
        expect { interactor }.to change { current_user.credit_cards.count }.by(1)
      end
    end
  end
end
