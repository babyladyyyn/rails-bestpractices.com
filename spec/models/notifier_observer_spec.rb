require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe NotifierObserver do

  include RailsBestPractices::Spec::Support

  it 'should be observing Comment#create' do
    post = Factory(:post)
    within_observable_scope do |observer|
      instance = Factory.build(:comment, :commentable => post)
      observer.should_receive(:notify).with(instance)
      instance.save
    end
  end

  it 'should be observing Answer#create' do
    question = Factory(:question)
    within_observable_scope do |observer|
      instance = Factory.build(:answer, :question => question)
      observer.should_receive(:notify).with(instance)
      instance.save
    end
  end

  it 'should create notification after creating a post comment' do
    within_observable_scope do |observer|
      post_user = Factory(:user, :login => 'post_user')
      post = Factory(:post, :title => 'notifierable post', :user => post_user)
      comment = Factory(:comment, :commentable => post)
      post_user.notifications.size.should == 1

      notification = post_user.notifications.first
      notification.notifierable.should == comment
      notification.user.should == post_user
    end
  end

  it 'should create notification after creating a question comment' do
    within_observable_scope do |observer|
      question_user = Factory(:user, :login => 'question_user')
      question = Factory(:question, :title => 'notifierable question', :user => question_user)
      comment = Factory(:comment, :commentable => question)
      question_user.notifications.size.should == 1

      notification = question_user.notifications.first
      notification.notifierable.should == comment
      notification.user.should == question_user
    end
  end

  it 'should create notification after creating an answer comment' do
    within_observable_scope do |observer|
      answer_user = Factory(:user, :login => 'answer_user')
      answer = Factory(:answer, :user => answer_user)
      comment = Factory(:comment, :commentable => answer)
      answer_user.notifications.size.should == 1

      notification = answer_user.notifications.first
      notification.notifierable.should == comment
      notification.user.should == answer_user
    end
  end

  it 'should create notification after creating a question answer' do
    within_observable_scope do |observer|
      question_user = Factory(:user, :login => 'question_user')
      question = Factory(:question, :title => 'notifierable question', :user => question_user)
      answer = Factory(:answer, :question => question)
      question_user.notifications.size.should == 1

      notification = question_user.notifications.first
      notification.notifierable.should == answer
      notification.user.should == question_user
    end
  end

  it 'should be observing Comment#destroy' do
    comment = Factory(:comment)
    within_observable_scope do |observer|
      observer.should_receive(:destroy).with(comment)
      comment.destroy
    end
  end

  it 'should destroy notification after destroying a post comment' do
    within_observable_scope do |observer|
      post_user = Factory(:user, :login => 'post_user')
      post = Factory(:post, :title => 'notifierable post', :user => post_user)
      comment = Factory(:comment, :commentable => post)
      post_user.notifications.size.should == 1

      comment.destroy
      post_user.notifications.size.should == 0
    end
  end

  it 'should destroy notification after destroying a question answer' do
    within_observable_scope do |observer|
      question_user = Factory(:user, :login => 'question_user')
      question = Factory(:question, :title => 'notifierable question', :user => question_user)
      answer = Factory(:answer, :question => question)
      question_user.notifications.size.should == 1

      answer.destroy
      question_user.notifications.size.should == 0
    end
  end

  it 'should not create notification after creating a comment to own post' do
    within_observable_scope do |observer|
      post_user = Factory(:user, :login => 'post_user')
      post = Factory(:post, :title => 'notifierable post', :user => post_user)
      comment = Factory(:comment, :commentable => post, :user => post_user)
      post_user.notifications.size.should == 0
    end
  end
end
