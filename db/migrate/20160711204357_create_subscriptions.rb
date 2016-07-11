class CreateSubscriptions < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'

    create_table :subscriptions, id: false do |t|
      t.primary_key :id, :uuid, default: 'uuid_generate_v1()'
      t.string :stripe_id
      t.boolean :cancel_at_period_end
      t.datetime :canceled_at
      t.datetime :created
      t.datetime :current_period_end
      t.datetime :current_period_start
      t.uuid :customer_id
      t.datetime :ended_at
      t.boolean :livemode
      t.integer :quantity
      t.datetime :start
      t.string :status
      t.datetime :trial_end
      t.datetime :trial_start

      t.timestamps null: false
    end
  end
end
