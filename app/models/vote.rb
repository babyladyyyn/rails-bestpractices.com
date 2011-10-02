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
  include Cacheable

  belongs_to :voteable, :polymorphic => true
  after_create :update_create_vote, :expire_voteable_cache
  before_destroy :update_destroy_vote
  after_destroy :expire_voteable_cache

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
        voteable_type.constantize.increment_counter(:vote_points, voteable_id)
      else
        voteable_type.constantize.decrement_counter(:vote_points, voteable_id)
      end
    end

    def update_destroy_vote
      if like?
        voteable_type.constantize.decrement_counter(:vote_points, voteable_id)
      else
        voteable_type.constantize.increment_counter(:vote_points, voteable_id)
      end
    end

    def expire_voteable_cache
      voteable.expire_vote_cache
      voteable.expire_model_cache
    end

end

