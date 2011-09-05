class CreateJobPartners < ActiveRecord::Migration
  def self.up
    create_table :job_partners do |t|
      t.string :name
      t.string :token

      t.timestamps
    end
  end

  def self.down
    drop_table :job_partners
  end
end
