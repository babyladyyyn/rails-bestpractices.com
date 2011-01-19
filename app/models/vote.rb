# == Schema Information
#
# Table name: votes
#
#  id            :integer(4)      not null, primary key
#  like          :boolean(1)
#  user_id       :integer(4)
#  voteable_id   :integer(4)
#  created_at    :datetime
#  updated_at    :datetime
#  voteable_type :string(255)
#

class Vote < ActiveRecord::Base

  include UserOwnable

  belongs_to :voteable, :polymorphic => true, :touch => true
  after_create :update_create_vote
  before_destroy :update_destroy_vote

  def voteable_name
    if voteable.is_a? Answer
      voteable.question.title
    else
      voteable.title
    end
  end

  private

    def update_create_vote
      if like?
        voteable.increment!(:vote_points)
      else
        voteable.decrement!(:vote_points)
      end
    end

    def update_destroy_vote
      if like?
        voteable.decrement!(:vote_points)
      else
        voteable.increment!(:vote_points)
      end
    end

end

