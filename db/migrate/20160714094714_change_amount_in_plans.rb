class ChangeAmountInPlans < ActiveRecord::Migration
  def up
    change_column :plans, :amount, :float
  end

  def down
    change_column :plans, :amount, :integer
  end
end
