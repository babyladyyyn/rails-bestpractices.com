class AddMissingIndexes2 < ActiveRecord::Migration
  def self.up

    # These indexes were found by searching for AR::Base finds on your application
    # It is strongly recommanded that you will consult a professional DBA about your infrastucture and implemntation before
    # changing your database in that matter.
    # There is a possibility that some of the indexes offered below is not required and can be removed and not added, if you require
    # further assistance with your rails application, database infrastructure or any other problem, visit:
    #
    # http://www.railsmentors.org
    # http://www.railstutor.org
    # http://guides.rubyonrails.org


    add_index :votes, [:voteable_id, :voteable_type]
    add_index :questions, :user_id
    add_index :answers, :question_id
    add_index :answers, :user_id
  end

  def self.down
    remove_index :votes, :column => [:voteable_id, :voteable_type]
    remove_index :questions, :user_id
    remove_index :answers, :question_id
    remove_index :answers, :user_id
  end
end
