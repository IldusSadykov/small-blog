require "rails_helper"

describe PostUserWrapper do
  let!(:creator) { create :user }
  let!(:customer) { create :customer }
  let!(:user) { create :user, customer: customer }
  let!(:plan) { create :plan, user: creator}
  let!(:post) { create :post, :published, user: creator, plan: plan }

  subject { described_class.new(post, user) }

  context "user have subscriptions" do
    let!(:subscription) { create :subscription, plan: plan, customer: customer }

    it "user subscribed to the post" do
      expect(subject.subscribed?).to eq true
    end

    it "posts have subscribed? method" do
      posts = PostUserWrapper.wrap([post], user)
      expect(posts.first).to respond_to(:subscribed?)
    end
  end

  context "user have not subscriptions" do
    it "user not subscribed to the post" do
      expect(subject.subscribed?).to eq false
    end

    it "posts have not subscribed? method" do
      posts = PostUserWrapper.wrap([post], user)
      expect(posts.first).to respond_to(:subscribed?)
    end
  end
end
