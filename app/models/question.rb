class Question < ActiveRecord::Base

  include Markdownable
  include UserOwnable
  include Voteable
  include Commentable

  acts_as_taggable

  has_many :answers, :dependent => :destroy

  validates_presence_of :title, :body
  validates_uniqueness_of :title

  scope :not_answered, where(:answers_count => 0)
  scope :search, lambda { |q| where(['questions.title LIKE ?', "%#{q}%"]) }

  INDEX_COLUMNS = (column_names - ['body', 'formatted_html', 'updated_at']).join(",")

  def self.per_page
    10
  end

  def tweet_title
    "Question: #{title}"
  end

  def tweet_path
    "questions/#{to_param}"
  end

  def to_param
    "#{id}-#{title.parameterize}"
  end

end
