class CreateLocations < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'

    create_table :locations, id: false do |t|
      t.primary_key :id, :uuid, default: 'uuid_generate_v1()'
      t.string :street
      t.string :city
      t.string :state
      t.uuid :country_id
      t.float :lat
      t.float :lon

      t.timestamps null: false
    end
  end
end
