# == Schema Information
#
# Table name: posts
#
#  id             :integer(4)      not null, primary key
#  title          :string(255)
#  body           :text(16777215)
#  created_at     :datetime
#  updated_at     :datetime
#  user_id        :integer(4)
#  formatted_html :text(16777215)
#  description    :text(16777215)
#  comments_count :integer(4)      default(0)
#  vote_points    :integer(4)      default(0)
#  view_count     :integer(4)
#  implemented    :boolean(1)      default(FALSE), not null
#  published      :boolean(1)      default(FALSE), not null
#

class Post < ActiveRecord::Base

  include UserOwnable
  include Voteable
  include Commentable
  include CacheTaggable

  has_one :post_body

  validates_presence_of :title
  validates_uniqueness_of :title

  scope :implemented, where(:implemented => true)
  scope :published, where(:published => true)

  after_create :notify_admin
  after_update :expire_cache


  accepts_nested_attributes_for :post_body

  paginates_per 10

  delegate :body, :to => :post_body

  define_index do
    indexes :title, :description
    indexes post_body(:body), :as => :body

    has :id

    set_property :field_weights => {
      :title       => 10,
      :description => 5,
      :body        => 1
    }

    where "published = 1"
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

  def publish!
    self.update_attribute(:published, true)
    Delayed::Job.enqueue(DelayedJob::Tweet.new('Post', self.id))
  end

  def related_posts
    model_cache.fetch("posts/related") do
      Post.select('id, title').where(['id <> ?', self.id]).limit(4).tagged_with(self.tag_list, :any => true).all
    end
  end

  def formatted_html
    model_cache.fetch("posts/#{self.id}/formatted_html") do
      self.post_body.formatted_html
    end
  end

  def cached_tags
    model_cache.fetch("posts/#{self.id}/tags") do
      self.tags.all
    end
  end

  protected
    def notify_admin
      Delayed::Job.enqueue(DelayedJob::NotifyAdmin.new(self.id))
    end

end

