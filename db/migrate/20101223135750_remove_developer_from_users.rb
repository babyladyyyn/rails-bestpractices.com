class RemoveDeveloperFromUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :developer
  end

  def self.down
    add_column :users, :developer, :boolean
  end
end
