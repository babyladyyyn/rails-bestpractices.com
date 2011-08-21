class CreateSponsors < ActiveRecord::Migration
  def self.up
    create_table :sponsors do |t|
      t.string :name
      t.string :website_url
      t.string :image_url
      t.boolean :active, :default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :sponsors
  end
end
