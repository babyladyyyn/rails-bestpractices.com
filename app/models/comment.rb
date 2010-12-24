class Comment < ActiveRecord::Base

  include UserOwnable

  belongs_to :commentable, :counter_cache => true, :polymorphic => true, :touch => true
  validates_presence_of :body
  validates_presence_of :username, :if => Proc.new { |comment| !comment.user_id }

  scope :post, where(:commentable_type => 'Post').order("comments.created_at desc")

  def self.per_page
    10
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
