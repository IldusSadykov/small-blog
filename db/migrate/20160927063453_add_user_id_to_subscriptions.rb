class AddUserIdToSubscriptions < ActiveRecord::Migration
  def change
    add_reference :subscriptions, :user, type: :uuid, index: true, foreign_key: true
    remove_reference :subscriptions, :customer, type: :uuid
  end
end
