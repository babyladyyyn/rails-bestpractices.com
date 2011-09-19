class AddSourceAndExternalIdToJobs < ActiveRecord::Migration
  def self.up
    add_column :jobs, :source, :string
    add_column :jobs, :external_id, :integer
  end

  def self.down
    remove_column :jobs, :external_id
    remove_column :jobs, :source
  end
end
