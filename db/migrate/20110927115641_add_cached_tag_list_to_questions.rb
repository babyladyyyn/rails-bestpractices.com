class AddCachedTagListToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :cached_tag_list, :string
    Question.reset_column_information
    ActsAsTaggableOn::Taggable::Cache.included(Question)
    Question.all.each do |q|
      q.tag_list
      q.save_cached_tag_list
      q.save!
    end
  end

  def self.down
    remove_column :questions, :cached_tag_list
  end
end
