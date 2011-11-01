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
  after_create :update_create_vote, :expire_voteable_and_user_cache
  after_destroy :update_destroy_vote, :expire_voteable_and_user_cache

  model_cache do
    with_association :voteable, :user
  end

  private
    def update_create_vote
      if like?
        voteable_type.constantize.increment_counter(:vote_points, voteable_id)
      else
        voteable_type.constantize.decrement_counter(:vote_points, voteable_id)
      end
      true
    end

    def update_destroy_vote
      if like?
        voteable_type.constantize.decrement_counter(:vote_points, voteable_id)
      else
        voteable_type.constantize.increment_counter(:vote_points, voteable_id)
      end
      true
    end

    def expire_voteable_and_user_cache
      voteable.expire_model_cache
      user.expire_model_cache
    end

end

