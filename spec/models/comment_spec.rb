require "rails_helper"

describe Comment do
  it { is_expected.to validate_presence_of :message }
  it { is_expected.to validate_presence_of :post }
  it { is_expected.to validate_presence_of :user }
  it { is_expected.to belong_to :post }
  it { is_expected.to belong_to :user }
end
