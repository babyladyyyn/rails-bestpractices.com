class DropImplementations < ActiveRecord::Migration
  def self.up
    drop_table :implementations
  end

  def self.down
    create_table :implementations do |t|
      t.integer :post_id
      t.integer :user_id
      t.text :body
      t.text :formatted_html

      t.timestamps
    end
  end
end
