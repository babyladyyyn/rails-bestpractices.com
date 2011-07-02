class AddMissingIndexes5 < ActiveRecord::Migration
  def self.up
    add_index :question_bodies, :question_id
    add_index :answer_bodies, :answer_id
  end

  def self.down
    remove_index :answer_bodies, :column => :answer_id
    remove_index :question_bodies, :column => :question_id
  end
end
