class FixIndexesForPolymorphicColumns < ActiveRecord::Migration
  def self.up
    remove_index :comments, :commentable_type
    remove_index :taggings, :tagger_id
    add_index :taggings, [:tagger_id, :tagger_type]
    remove_index :votes, :name => "index_votes_on_post_id"
  end

  def self.down
    add_index :votes, :voteable_id, :name => "index_votes_on_post_id"
    remove_index :taggings, :column => [:tagger_id, :tagger_type]
    add_index :taggings, :tagger_id
    add_index :comments, :commentable_type
  end
end
