require "rails_helper"
require "stripe_mock"

describe Webhooks::SubscriptionsController do
  before { StripeMock.start }

  after { StripeMock.stop }

  describe "POST #create" do
    let(:user) { create :user, stripe_customer_id: event.data.object.customer }
    let(:stripe_subscription) { event.data.object }
    let!(:subscription) { create :subscription, user: user, stripe_id: stripe_subscription.id }

    def post_request(event_id)
      post "create",
        id: event_id,
        format: "json"
    end

    context "response with invoice payment succeeded" do
      let(:event) { StripeMock.mock_webhook_event("invoice.payment_succeeded") }
      let(:stripe_subscription) { event.data.object.lines.data.last }

      it "a request with valid params" do
        post_request(event.id)

        subscription.reload

        expect(response).to be_success
        expect(response.code).to eq "201"
        expect(subscription.current_period_start).to eq Time.zone.at(stripe_subscription.period.start)
        expect(subscription.current_period_end).to eq Time.zone.at(stripe_subscription.period.end)
      end
    end

    context "response with invoice payment failed" do
      let(:event) { StripeMock.mock_webhook_event("invoice.payment_failed") }
      let!(:user_mailer) { double :user_mailer }

      before do
        allow(UserMailer).to receive(:payment_failed).and_return(user_mailer)
        allow(user_mailer).to receive(:deliver)
      end

      it "a request should not update subscription" do
        subscription.reload

        expect { post_request(event.id) }.to_not change { subscription.plan.name }
        expect(response).to be_success
        expect(response.code).to eq "201"
        expect(user_mailer).to have_received(:deliver)
      end
    end

    context "response with customer subscription updated" do
      let(:event) { StripeMock.mock_webhook_event("customer.subscription.updated") }
      let(:stripe_plan) { event.data.object.plan }
      let(:plan) { create :plan, stripe_id: stripe_plan.id }

      it "a request with valid params" do
        post_request(event.id)

        subscription.reload

        expect(response).to be_success
        expect(response.code).to eq "201"
      end
    end
  end
end
