class CreateCountries < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'

    create_table :countries, id: false do |t|
      t.primary_key :id, :uuid, default: 'uuid_generate_v1()'
      t.string :name
      t.string :code

      t.timestamps null: false
    end
  end
end
