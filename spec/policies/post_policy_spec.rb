require "rails_helper"

describe PostPolicy do
  let(:current_user) { build :user }
  let(:post) { build :post }

  subject { described_class.new(current_user, post) }

  it { is_expected.not_to permit_action(:edit) }
  it { is_expected.not_to permit_action(:update) }
  it { is_expected.not_to permit_action(:delete) }

  describe "#update?" do
    subject { described_class.new(current_user, post).update? }

    context "some post with published status" do
      let(:post) { build :post, published: true }
      it { is_expected.not_to be_permitted }
    end

    context "some post without published status" do
      let(:post) { build :post, published: false }
      it { is_expected.not_to be_permitted }
    end

    context "current_user post without published status" do
      let(:post) { build :post, published: false, author: current_user }
      it { is_expected.to be_permitted }
    end

    context "current_user post with published status" do
      let(:post) { build :post, published: true, author: current_user }
      it { is_expected.not_to be_permitted }
    end
  end
end
