class AddLocationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :location_id, :uuid
    add_index :users, :location_id
  end
end
