class ChangeCurrencyDefaultInPlans < ActiveRecord::Migration
  def up
    change_column_default :plans, :currency, "USD"
  end

  def down
    change_column_default :plans, :currency, ""
  end
end
