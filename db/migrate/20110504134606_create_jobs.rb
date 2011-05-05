class CreateJobs < ActiveRecord::Migration
  def self.up
    create_table :jobs do |t|
      t.string :title
      t.text :description
      t.string :company
      t.string :company_url
      t.string :country
      t.string :state
      t.string :city
      t.string :address
      t.string :salary
      t.string :apply_email

      t.timestamps
    end
  end

  def self.down
    drop_table :jobs
  end
end
