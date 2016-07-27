class AddConstraintsToPlans < ActiveRecord::Migration
  def up
    add_foreign_key :plans, :users
    change_column :plans, :amount, :decimal, null: false
    change_column_null :plans, :name, false
    change_column_null :plans, :stripe_id, false
    change_column_null :plans, :currency, false

    add_index :plans, :user_id
  end

  def down
    remove_foreign_key :plans, :user
    change_column :plans, :amount, :float, null: true
    change_column_null :plans, :name, true
    change_column_null :plans, :stripe_id, true
    change_column_null :plans, :currency, true

    remove_index :plans, :user_id
  end
end
