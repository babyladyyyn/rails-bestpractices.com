class RemoveCommentsFromImplementations < ActiveRecord::Migration
  def self.up
    remove_column :implementations, :comments_count
  end

  def self.down
    add_column :implementations, :comments_count
  end
end
