class CreateNotificationSettings < ActiveRecord::Migration
  def self.up
    create_table :notification_settings do |t|
      t.string :name
      t.boolean :value, :default => true
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :notification_settings
  end
end
