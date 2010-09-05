class AddTagListToDrops < ActiveRecord::Migration
  def self.up
    add_column :drops, :tag_list, :string
  end

  def self.down
    remove_column :drops, :tag_list
  end
end
