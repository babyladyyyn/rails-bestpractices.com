# == Schema Information
#
# Table name: answers
#
#  id             :integer(4)      not null, primary key
#  body           :text(16777215)
#  formatted_html :text(16777215)
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

  belongs_to :question, :counter_cache => true, :touch => true
  has_one :answer_body

  accepts_nested_attributes_for :answer_body

  paginates_per 10

  delegate :body, :formatted_html, :to => :answer_body

  def to_post
    Post.new(:title => self.question.title, :post_body => PostBody.new(:body => self.body), :tag_list => self.question.tag_list)
  end

  def tweet_title
    "Answer for #{question.title}"
  end

  def tweet_path
    "questions/#{question.to_param}"
  end

end

