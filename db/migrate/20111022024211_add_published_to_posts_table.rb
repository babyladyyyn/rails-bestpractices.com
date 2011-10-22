class AddPublishedToPostsTable < ActiveRecord::Migration
  def self.up
    remove_index :posts, :column => :user_id
    add_index :posts, :published
    add_index :posts, [:user_id, :published]
  end

  def self.down
    remove_index :posts, :column => [:user_id, :published]
    remove_index :posts, :column => :published
    add_index :posts, :user_id
  end
end
