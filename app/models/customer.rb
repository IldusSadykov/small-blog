class Customer < ActiveRecord::Base
  has_many :subscriptions
  has_many :users
end
