require 'spec_helper'

describe NotifierObserver do

  include RailsBestPractices::Spec::Support

  it 'should be observing Answer#create' do
    question = Factory(:question)
    within_observable_scope do |observer|
      instance = Factory.build(:answer, :question => question)
      observer.should_receive(:notify).with(instance)
      instance.save
    end
  end

  it 'should create notification after creating a question answer' do
    within_observable_scope do |observer|
      question_user = Factory(:user, :login => 'question_user')
      question = Factory(:question, :title => 'notifierable question', :user => question_user)
      answer = Factory(:answer, :question => question)
      question_user.reload
      question_user.notifications.size.should == 1

      notification = question_user.notifications.first
      notification.notifierable.should == answer
      notification.user.should == question_user
    end
  end

  it 'should destroy notification after destroying a question answer' do
    within_observable_scope do |observer|
      question_user = Factory(:user, :login => 'question_user')
      question = Factory(:question, :title => 'notifierable question', :user => question_user)
      answer = Factory(:answer, :question => question)
      question_user.reload
      question_user.notifications.size.should == 1

      answer.destroy
      question_user.reload
      question_user.notifications.size.should == 0
    end
  end
end
