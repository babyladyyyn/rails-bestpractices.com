module Voteable

  def self.included(base)
    base.class_eval do
      has_many :votes, :as => :voteable, :dependent => :destroy
    end
  end

  def vote(user)
    Rails.cache.fetch "#{self.class.to_s.tableize}/#{self.id}/users/#{user.id}/vote" do
      self.votes.where(:user_id => user.id).first
    end
  end

end
