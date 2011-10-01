class AddCachedTagListToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :cached_tag_list, :string
    Post.reset_column_information
    ActsAsTaggableOn::Taggable::Cache.included(Post)
    Post.all.each do |p|
      p.tag_list
      p.save_cached_tag_list
      p.save!
    end
  end

  def self.down
    remove_column :posts, :cached_tag_list
  end
end
