require "rails_helper"

describe Webhooks::SubscriptionsController do
  let!(:user) { create :user, stripe_customer_id: event_response.data.object.customer }
  let!(:subscription) { create :subscription, user: user, stripe_id: stripe_subscription_id }

  def post_request
    post "create",
      event_id: event_response.id,
      format: "json"
  end

  describe "POST #create" do
    context "response with invoice payment succeeded" do
      let!(:event_response) do
        result = JSON.parse(
          File.read("spec/fixtures/webhooks/payment_succeeded.json")
        )
        Stripe::StripeObject.construct_from(result)
      end
      let!(:stripe_subscription) { event_response.data.object.lines.data[0] }
      let!(:stripe_subscription_id) { stripe_subscription.id }

      before do
        allow(Stripe::Event).to receive(:retrieve).and_return(event_response)
        post_request
      end

      it "a request with valid params" do
        subscription.reload
        expect(response).to be_success
        expect(response.code).to eq "201"
        expect(subscription.current_period_start).to eq Time.zone.at(stripe_subscription.period.start)
        expect(subscription.current_period_end).to eq Time.zone.at(stripe_subscription.period.end)
      end
    end

    context "response with invoice payment failed" do
      let!(:event_response) do
        result = JSON.parse(
          File.read("spec/fixtures/webhooks/payment_failed.json")
        )
        Stripe::StripeObject.construct_from(result)
      end
      let!(:stripe_subscription) { event_response.data.object.lines.data[0] }
      let!(:stripe_subscription_id) { stripe_subscription.id }
      let!(:user_mailer) { double :user_mailer }

      before do
        allow(Stripe::Event).to receive(:retrieve).and_return(event_response)
        allow(UserMailer).to receive(:payment_failed).and_return(user_mailer)
        allow(user_mailer).to receive(:deliver)
      end

      it "a request should not update subscription" do
        subscription.reload
        expect { post_request }.to_not change { subscription.plan.name }
        expect(response).to be_success
        expect(response.code).to eq "201"
      end

      it "a request should send email" do
        post_request
        expect(user_mailer).to have_received(:deliver)
      end
    end

    context "response with customer subscription updated" do
      let!(:event_response) do
        result = JSON.parse(
          File.read("spec/fixtures/webhooks/customer_subscription_updated.json")
        )
        Stripe::StripeObject.construct_from(result)
      end
      let!(:stripe_subscription_id) { event_response.data.object.id }
      let!(:stripe_plan) { event_response.data.object.plan }
      let!(:plan) { create :plan, stripe_id: stripe_plan.id }

      before do
        allow(Stripe::Event).to receive(:retrieve).and_return(event_response)

        post_request
      end

      it "a request with valid params" do
        subscription.reload
        expect(response).to be_success
        expect(response.code).to eq "201"
      end
    end
  end
end
