class CreatePosts < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'

    create_table :posts, id: false do |t|
      t.primary_key :id, :uuid, default: 'uuid_generate_v1()'
      t.string :title
      t.text :body
      t.belongs_to :category, index: true, type: 'uuid'
      t.belongs_to :user, index: true, type: 'uuid'
      t.boolean :published, default: false, null: false
      t.integer :updated_by

      t.timestamps
    end
  end
end
