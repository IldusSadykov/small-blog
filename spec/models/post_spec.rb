require "rails_helper"

describe Post do
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :body }
  it { is_expected.to validate_presence_of :category }
  it { is_expected.to validate_presence_of :user }
  it { is_expected.to have_many :comments }
  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :category }
end
