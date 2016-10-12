class RemoveCustomersTable < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'

    drop_table :customers, id: false do |t|
      t.primary_key :id, :uuid, default: 'uuid_generate_v1()'
      t.string :stripe_id
      t.float :account_balance
      t.datetime :created
      t.string :currency
      t.string :description
      t.string :email
      t.string :livemode

      t.timestamps null: false
    end
  end
end
