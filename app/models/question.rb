# == Schema Information
#
# Table name: questions
#
#  id             :integer(4)      not null, primary key
#  title          :string(255)
#  user_id        :integer(4)
#  vote_points    :integer(4)      default(0)
#  view_count     :integer(4)      default(0)
#  answers_count  :integer(4)      default(0)
#  created_at     :datetime
#  updated_at     :datetime
#  comments_count :integer(4)      default(0)
#

class Question < ActiveRecord::Base

  include UserOwnable
  include Voteable
  include Commentable
  include Cacheable

  paginates_per 10

  has_many :answers, :dependent => :destroy
  has_one :question_body, :dependent => :destroy

  validates :title, :presence => true, :uniqueness => true

  scope :not_answered, where(:answers_count => 0)

  after_create :tweet_it, :expire_user_cache
  after_destroy :expire_user_cache

  accepts_nested_attributes_for :question_body

  delegate :body, :formatted_html, :to => :question_body

  acts_as_taggable

  define_index do
    indexes :title
    indexes question_body(:body), :as => :body

    has :id

    set_property :field_weights => {
      :title => 10,
      :body  => 1
    }
  end

  model_cache do
    with_key
    with_method :formatted_html
    with_association :user
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

  protected
    def tweet_it
      Delayed::Job.enqueue(DelayedJob::Tweet.new('Question', self.id))
    end

    def expire_user_cache
      user.expire_model_cache
    end

end

