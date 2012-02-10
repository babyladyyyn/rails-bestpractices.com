class SetImportantToFalseForTags < ActiveRecord::Migration
  def up
    change_column :tags, :important, :boolean, :default => false, :null => false
  end

  def down
    change_column :tags, :important, :boolean, :default => true, :null => false
  end
end
