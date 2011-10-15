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

require 'spec_helper'

describe Comment do

  include RailsBestPractices::Spec::Support
  should_be_user_ownable
  should_have_entries_per_page 10

  should_belong_to :commentable, :polymorphic => true
  should_validate_presence_of :body

  describe 'validating username when it is required' do
    subject { Factory(:comment, :user => nil, :username => 'flyerhzm') }
    should_validate_presence_of :username
  end

  describe 'validating username when it is not required' do
    subject { Factory(:comment) }
    should_not_validate_presence_of :username
  end

  it 'should be scopable by post type (sorted by creation timing)' do
    Comment.delete_all
    comment1 = Factory(:comment, :commentable => Factory(:post), :created_at => 3.days.ago)
    comment2 = Factory(:comment, :commentable => Factory(:post), :created_at => 1.days.ago)
    Comment.for_post.should == [comment2, comment1]
  end

end

