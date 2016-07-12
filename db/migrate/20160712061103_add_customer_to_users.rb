class AddCustomerToUsers < ActiveRecord::Migration
  def change
    add_column :users, :customer_id, :uuid
  end
end
