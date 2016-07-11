class AddPlanToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :plan_id, :uuid
  end
end
