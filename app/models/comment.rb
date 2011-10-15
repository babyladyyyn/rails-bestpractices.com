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
  include Cacheable

  belongs_to :commentable, :counter_cache => true, :polymorphic => true
  validates_presence_of :body
  validates_presence_of :username, :if => Proc.new { |comment| !comment.user_id }

  scope :for_post, where(:commentable_type => 'Post').order("comments.created_at desc")

  paginates_per 10

  after_create :expire_commentable_and_user_cache
  after_destroy :expire_commentable_and_user_cache

  model_cache do
    with_key
    with_association :user, :commentable
  end

  private
    def expire_commentable_and_user_cache
      cached_commentable.expire_model_cache
      cached_user.expire_model_cache if cached_user
    end

end

