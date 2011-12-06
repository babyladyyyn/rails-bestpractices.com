# == Schema Information
#
# Table name: comments
#
#  id               :integer(4)      not null, primary key
#  body             :text
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
  include Cacheable

  belongs_to :commentable, :counter_cache => true, :polymorphic => true
  validates :body, :presence => true
  validates :username, :presence => true, :if => Proc.new { |comment| !comment.user_id }

  scope :for_post, where(:commentable_type => 'Post').order("comments.created_at desc")

  after_create :expire_commentable_and_user_cache
  after_destroy :expire_commentable_and_user_cache

  model_cache do
    with_key
    with_association :user, :commentable
  end

  def user_name
    cached_user ? cached_user.login : username
  end

  def user_email
    cached_user ? cached_user.email : email
  end

  def parent_name
    commentable = cached_commentable
    case commentable
    when Question
      "Question #{commentable.title}"
    when Answer
      "Answer of #{commentable.cached_question.title}"
    when Post
      "Post #{commentable.title}"
    when BlogPost
      "Blog Post #{commentable.title}"
    end
  end

  private
    def expire_commentable_and_user_cache
      commentable.expire_model_cache
      user.expire_model_cache if user
    end

end

