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
  include Cacheable

  has_one :post_body

  validates :title, :presence => true, :uniqueness => true
  validates :description, :presence => true

  scope :implemented, where(:implemented => true)
  scope :published, where(:published => true)

  after_create :notify_admin

  accepts_nested_attributes_for :post_body

  delegate :body, :formatted_html, :to => :post_body

  acts_as_taggable

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

  model_cache do
    with_key
    with_method :formatted_html
    with_association :user
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
    expire_user_cache
    expire_post_cell_cache
    Delayed::Job.enqueue(DelayedJob::Tweet.new('Post', self.id))
  end

  def related_posts
    Post.where(['posts.id <> ?', self.id]).limit(4).tagged_with(self.tag_list, :any => true).all
  end

  def prev(order)
    if order == "implemented"
      Post.published.implemented.where(["id < ?", self.id]).order("id desc").limit(1).first
    else
      Post.published.where(["#{order} < ?", self.send(order)]).order("#{order} desc").limit(1).first
    end
  end

  def next(order)
    if order == "implemented"
      Post.published.implemented.where(["id > ?", self.id]).order("id asc").limit(1).first
    else
      Post.published.where(["#{order} > ?", self.send(order)]).order("#{order} asc").limit(1).first
    end
  end

  protected
    def notify_admin
      Delayed::Job.enqueue(DelayedJob::NotifyAdmin.new(self.id))
    end

    def expire_user_cache
      user.expire_model_cache
    end

    def expire_post_cell_cache
      Rails.cache.delete "cells/post/prev_next/#{prev("id").model_cache_key}" if prev("id")
    end

end

