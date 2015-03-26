class CreateComments < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'

    create_table :comments, id: false do |t|
      t.primary_key :id, :uuid, default: 'uuid_generate_v1()'
      t.text :message
      t.belongs_to :user, type: 'uuid'
      t.belongs_to :post, index: true, type: 'uuid'

      t.timestamps
    end
  end
end
