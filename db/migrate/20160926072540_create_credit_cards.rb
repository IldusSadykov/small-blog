class CreateCreditCards < ActiveRecord::Migration
  def change
    create_table :credit_cards do |t|
      t.string :stripe_id
      t.string :brand
      t.string :last4
      t.string :name
      t.uuid :user_id

      t.timestamps null: false
    end
  end
end
