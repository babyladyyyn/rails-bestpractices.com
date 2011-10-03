module Voteable

  def self.included(base)
    base.class_eval do
      has_many :votes, :as => :voteable, :dependent => :destroy
    end
  end

  def cached_vote(user)
    Rails.cache.fetch vote_cache_key(user) do
      self.votes.where(:user_id => user.id).first
    end
  end

  def expire_vote_cache(user)
    Rails.cache.delete vote_cache_key(user)
  end

  def vote_cache_key(user)
    "#{model_cache_key}/users/#{user.id}/vote"
  end

end
