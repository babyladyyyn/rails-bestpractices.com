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

  include Markdownable
  include UserOwnable
  include Voteable
  include Commentable

  acts_as_taggable

  has_many :answers, :dependent => :destroy

  validates_presence_of :title, :body
  validates_uniqueness_of :title

  scope :not_answered, where(:answers_count => 0)

  after_create :tweet_it

  paginates_per 10

  define_index do
    indexes :title, :body

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

