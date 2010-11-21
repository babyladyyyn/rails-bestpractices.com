class AddMissingIndexes3 < ActiveRecord::Migration
  def self.up
    add_index :access_tokens, :user_id
    add_index :drops, :user_id
    add_index :notification_settings, :user_id
    add_index :notifications, :user_id
    add_index :notifications, [:notifierable_id, :notifierable_type]
    add_index :taggings, :tagger_id
  end

  def self.down
    remove_index :taggings, :column => :tagger_id
    remove_index :notifications, :column => [:notifierable_id, :notifierable_type]
    remove_index :notifications, :column => :user_id
    remove_index :notification_settings, :column => :user_id
    remove_index :drops, :column => :user_id
    remove_index :access_tokens, :column => :user_id
  end
end
