# == Schema Information
#
# Table name: answers
#
#  id             :integer(4)      not null, primary key
#  user_id        :integer(4)
#  vote_points    :integer(4)      default(0)
#  question_id    :integer(4)
#  created_at     :datetime
#  updated_at     :datetime
#  comments_count :integer(4)      default(0)
#

class Answer < ActiveRecord::Base

  include UserOwnable
  include Voteable
  include Commentable
  include Cacheable

  belongs_to :question, :counter_cache => true, :touch => true
  has_one :answer_body

  accepts_nested_attributes_for :answer_body

  paginates_per 10

  delegate :body, :formatted_html, :to => :answer_body

  after_create :expire_question_and_user_cache
  after_destroy :expire_question_and_user_cache

  model_cache do
    with_key
    with_method :formatted_html, :user, :question
  end

  def to_post
    Post.new(:title => self.cached_question.title, :post_body => PostBody.new(:body => self.body), :cached_tag_list => self.cached_question.tag_list)
  end

  def tweet_title
    "Answer for #{cached_question.title}"
  end

  def tweet_path
    "questions/#{cached_question.to_param}"
  end

  private
    def expire_question_and_user_cache
      cached_question.expire_model_cache
      cached_user.expire_model_cache
    end

end

