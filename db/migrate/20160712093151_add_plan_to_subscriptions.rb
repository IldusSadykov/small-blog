class AddPlanToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :plan_id, :uuid
  end
end
