require "spec_helper"

describe DelayedJob::Tweet do

  describe "perform" do
    it "should tweet post" do
      post = Factory(:post)
      delayed_tweet = DelayedJob::Tweet.new('Post', post.id)
      delayed_tweet.should_receive(:tweet).with(post.tweet_title, post.tweet_path)
      delayed_tweet.perform
    end

    it "should tweet implmentation" do
      post = Factory(:post)
      implementation = Factory(:implementation, :post => post)
      delayed_tweet = DelayedJob::Tweet.new('Implementation', implementation.id)
      delayed_tweet.should_receive(:tweet).with(implementation.tweet_title, implementation.tweet_path)
      delayed_tweet.perform
    end

    it "should tweet question" do
      question = Factory(:question)
      delayed_tweet = DelayedJob::Tweet.new('Question', question.id)
      delayed_tweet.should_receive(:tweet).with(question.tweet_title, question.tweet_path)
      delayed_tweet.perform
    end
  end
end
