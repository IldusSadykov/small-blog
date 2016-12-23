class RemovePublishedFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :published, :boolean, default: false, null: false
  end
end
