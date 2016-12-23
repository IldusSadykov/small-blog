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

    context "author have not access to another post" do
      let(:post) { build :post }
      it { is_expected.not_to be_permitted }
    end

    context "author have access to own post" do
      let(:post) { build :post, author: current_user }
      it { is_expected.to be_permitted }
    end
  end
end
