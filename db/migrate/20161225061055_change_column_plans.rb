class ChangeColumnPlans < ActiveRecord::Migration
  def up
    change_column :plans, :amount, :integer
  end

  def down
    change_column :plans, :amount, :float
  end
end
