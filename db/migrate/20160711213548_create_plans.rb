class CreatePlans < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'

    create_table :plans, id: false do |t|
      t.primary_key :id, :uuid, default: 'uuid_generate_v1()'
      t.string :stripe_id
      t.string :name
      t.integer :amount
      t.datetime :created
      t.string :currency
      t.string :interval
      t.integer :interval_count
      t.boolean :livemode
      t.text :statement_descriptor
      t.integer :trial_period_days
      t.uuid :user_id

      t.timestamps null: false
    end
  end
end
