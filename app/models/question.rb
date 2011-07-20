# == Schema Information
#
# Table name: questions
#
#  id             :integer(4)      not null, primary key
#  title          :string(255)
#  body           :text(16777215)
#  formatted_html :text(16777215)
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

  acts_as_taggable

  has_many :answers, :dependent => :destroy
  has_one :question_body

  validates_presence_of :title
  validates_uniqueness_of :title

  scope :not_answered, where(:answers_count => 0)

  after_create :tweet_it

  accepts_nested_attributes_for :question_body

  paginates_per 10

  delegate :body, :formatted_html, :to => :question_body

  define_index do
    indexes :title
    indexes question_body(:body), :as => :body

    has :id

    set_property :field_weights => {
      :title => 10,
      :body  => 1
    }
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

end

