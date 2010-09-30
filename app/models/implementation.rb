class Implementation < ActiveRecord::Base

  include Markdownable
  include UserOwnable

  belongs_to :post, :touch => true
  validates_presence_of :body
  after_create :cache_post

  def self.per_page
    10
  end

  def tweet_title
    "Implementation of #{post.title}"
  end

  def tweet_path
    "posts/#{post.to_param}/implementation"
  end

  protected
    def cache_post
      self.post.update_attribute(:implemented, true)
    end

end
