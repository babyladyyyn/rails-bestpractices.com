class AddPublishedToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :published, :boolean, :default => false, :null => false

    Post.update_all :published => true
  end

  def self.down
    remove_column :posts, :published
  end
end
