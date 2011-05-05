class CreateJobJobTypes < ActiveRecord::Migration
  def self.up
    create_table :job_job_types do |t|
      t.integer :job_id
      t.integer :job_type_id

      t.timestamps
    end
  end

  def self.down
    drop_table :job_job_types
  end
end
