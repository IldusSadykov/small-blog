require "rails_helper"

describe FetchORCreateCustomer do
  before { StripeMock.start }

  after { StripeMock.stop }

  describe ".call" do
    let(:stripe_customer) do
      Stripe::Customer.create(
        email: current_user.email
      )
    end

    subject(:interactor) do
      described_class.call(
        current_user: current_user,
        stripe_email: current_user.email
      )
    end

    context "when user customer exists" do
      let!(:current_user) { create :user }

      before { current_user.update(stripe_customer_id: stripe_customer.id) }

      it "does fetch customer" do
        expect(interactor.customer).to eq stripe_customer
      end
    end

    context "when user customer doesn't exist" do
      let!(:current_user) { create :user }

      it "does create stripe customer" do
        expect(interactor.customer.id).to eq current_user.stripe_customer_id
      end
    end
  end
end
