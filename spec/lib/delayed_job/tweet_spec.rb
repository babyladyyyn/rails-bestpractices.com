require "spec_helper"

describe DelayedJob::Tweet do

  describe "perform" do
    it "should tweet post" do
      post = FactoryGirl.create(:post)
      delayed_tweet = DelayedJob::Tweet.new('Post', post.id, true)
      delayed_tweet.should_receive(:init_twitter)
      delayed_tweet.should_receive(:tweet).with(post.tweet_title, post.tweet_path)
      delayed_tweet.perform
    end

    it "should tweet question" do
      question = FactoryGirl.create(:question)
      delayed_tweet = DelayedJob::Tweet.new('Question', question.id, true)
      delayed_tweet.should_receive(:init_twitter)
      delayed_tweet.should_receive(:tweet).with(question.tweet_title, question.tweet_path)
      delayed_tweet.perform
    end
  end
end
