class AddImportantToTags < ActiveRecord::Migration
  def self.up
    add_column :tags, :important, :boolean, :default => true, :null => false
  end

  def self.down
    remove_column :tags, :important
  end
end
