class RemoveImplemenationsCountFromUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :implementations_count
  end

  def self.down
    add_column :users, :implementations_count, :default => 0
  end
end
