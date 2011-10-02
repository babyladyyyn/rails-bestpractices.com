# == Schema Information
#
# Table name: comments
#
#  id               :integer(4)      not null, primary key
#  body             :text(16777215)
#  commentable_id   :integer(4)
#  commentable_type :string(255)
#  user_id          :integer(4)
#  username         :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  email            :string(255)
#

class Comment < ActiveRecord::Base

  include UserOwnable

  belongs_to :commentable, :counter_cache => true, :polymorphic => true, :touch => true
  validates_presence_of :body
  validates_presence_of :username, :if => Proc.new { |comment| !comment.user_id }

  scope :post, where(:commentable_type => 'Post').order("comments.created_at desc")

  paginates_per 10

  model_cache do
    with_method :user
  end

  def user_name
    user ? user.login : username
  end

  def user_email
    user ? user.email : email
  end

  def parent_name
    case commentable
    when Question
      "Question #{commentable.title}"
    when Answer
      "Answer of #{commentable.question.title}"
    when Post
      "Post #{commentable.title}"
    when BlogPost
      "Blog Post #{commentable.title}"
    end
  end

end

