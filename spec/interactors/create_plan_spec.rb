require "rails_helper"

describe CreatePlan do
  before { StripeMock.start }

  after { StripeMock.stop }

  describe ".call" do
    let(:stripe_helper) { StripeMock.create_test_helper }

    let!(:current_user) { create :user }

    subject(:interactor) do
      described_class.call(
        current_user: current_user,
        plan: build_plan
      )
    end

    context "when plan valid exists" do
      let(:build_plan) { build :plan }

      it "creates user plans" do
        expect { interactor }.to change { current_user.plans.count }.by(1)
      end
    end

    context "when plan is not valid" do
      let(:build_plan) { build :plan, name: nil, amount: nil }

      it "creates user plans" do
        expect { interactor }.to_not change { current_user.plans.count }
      end
    end
  end
end
