class AddMissingIndexes4 < ActiveRecord::Migration
  def self.up
    add_index :authentications, :user_id
    add_index :blog_posts, :user_id
    add_index :job_job_types, :job_id
    add_index :job_job_types, :job_type_id
    add_index :jobs, :user_id
    add_index :post_bodies, :post_id
  end

  def self.down
    remove_index :post_bodies, :column => :post_id
    remove_index :jobs, :column => :user_id
    remove_index :job_job_types, :column => :job_type_id
    remove_index :job_job_types, :column => :job_id
    remove_index :blog_posts, :column => :user_id
    remove_index :authentications, :column => :user_id
  end
end
