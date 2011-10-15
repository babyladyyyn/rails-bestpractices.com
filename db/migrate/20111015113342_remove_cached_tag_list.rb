class RemoveCachedTagList < ActiveRecord::Migration
  def self.up
    remove_column :posts, :cached_tag_list
    remove_column :questions, :cached_tag_list
  end

  def self.down
    add_column :questions, :cached_tag_list
    add_column :posts, :cached_tag_list
  end
end
