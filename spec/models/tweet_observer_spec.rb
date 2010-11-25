require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe TweetObserver do

  include RailsBestPractices::Spec::Support

  it 'should be observing Post#create' do
    Post.delete_all
    within_observable_scope do |observer|
      instance = Factory.build(:post, :id => 1)
      delayed_tweet = stub
      DelayedJob::Tweet.should_receive(:new).with('Post', 1).and_return(delayed_tweet)
      Delayed::Job.should_receive(:enqueue).with(delayed_tweet)
      instance.save
    end
  end

  it 'should be observing Implementation#create' do
    post = Factory(:post)
    within_observable_scope do |observer|
      instance = Factory.build(:implementation, :id => 1, :post => post)
      delayed_tweet = stub
      DelayedJob::Tweet.should_receive(:new).with('Implementation', 1).and_return(delayed_tweet)
      Delayed::Job.should_receive(:enqueue).with(delayed_tweet)
      instance.save
    end
  end

  it 'should be observing Question#create' do
    Question.delete_all
    within_observable_scope do |observer|
      instance = Factory.build(:question, :id => 1)
      delayed_tweet = stub
      DelayedJob::Tweet.should_receive(:new).with('Question', 1).and_return(delayed_tweet)
      Delayed::Job.should_receive(:enqueue).with(delayed_tweet)
      instance.save
    end
  end

end
