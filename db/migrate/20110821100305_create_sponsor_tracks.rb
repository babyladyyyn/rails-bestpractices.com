class CreateSponsorTracks < ActiveRecord::Migration
  def self.up
    create_table :sponsor_tracks do |t|
      t.integer :sponsor_id

      t.timestamps
    end
    add_index :sponsor_tracks, :sponsor_id
  end

  def self.down
    remove_index :sponsor_tracks, :sponsor_id
    drop_table :sponsor_tracks
  end
end
