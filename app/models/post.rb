class Post < ActiveRecord::Base

  include Markdownable
  include UserOwnable
  include Voteable
  include Commentable

  acts_as_taggable

  has_one :implementation, :dependent => :destroy
  validates_presence_of :title, :body
  validates_uniqueness_of :title

  default_scope order('created_at desc')
  scope :search, lambda { |q| where(['title LIKE ?', "%#{q}%"]) }
  scope :implemented, where(:implemented => true)
  with_exclusive_scope do
    scope :hot, order('vote_points desc')
    scope :most_voted, order('vote_points desc')
    scope :most_commented, order('comments_count desc')
  end

  def self.per_page
    10
  end

  def tweet_title
    title
  end

  def tweet_path
    "posts/#{to_param}"
  end

  def to_param
    "#{id}-#{title.parameterize}"
  end

  def related_posts
    Post.tagged_with(self.tag_list, :any => true).select('id, title').where(['id <> ?', self.id]).limit(4)
  end

end
