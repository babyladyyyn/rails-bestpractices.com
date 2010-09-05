class CreateDrops < ActiveRecord::Migration
  def self.up
    create_table :drops do |t|
      t.string :title
      t.text :body
      t.integer :user_id
      t.text :formatted_html
      t.text :description
      t.string :kind

      t.timestamps
    end
  end

  def self.down
    drop_table :drops
  end
end
