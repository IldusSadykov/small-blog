class CreateCategories < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'

    create_table :categories, id: false do |t|
      t.primary_key :id, :uuid, default: 'uuid_generate_v1()'
      t.string :name
      t.string :slug

      t.timestamps
    end

    add_index :categories, :slug, unique: true
  end
end
