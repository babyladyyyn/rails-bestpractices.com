class Post < ActiveRecord::Base

  include Markdownable
  include UserOwnable
  include Voteable
  include Commentable

  acts_as_taggable

  has_one :implementation, :dependent => :destroy
  validates_presence_of :title, :body
  validates_uniqueness_of :title

  scope :search, lambda { |q| where(['posts.title LIKE ?', "%#{q}%"]) }
  scope :implemented, where(:implemented => true)

  INDEX_COLUMNS = (column_names - ['body', 'formatted_html', 'updated_at']).join(",")

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
    Post.select('id, title').where(['id <> ?', self.id]).limit(4).tagged_with(self.tag_list, :any => true)
  end

end
