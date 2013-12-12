require "spec_helper"

describe DelayedJob::Tweet do

  describe "perform" do
    it "should tweet post" do
      post = FactoryGirl.create(:post)
      delayed_tweet = DelayedJob::Tweet.new('Post', post.id, true)
      expect(delayed_tweet).to receive(:init_twitter)
      expect(delayed_tweet).to receive(:tweet).with(post.tweet_title, post.tweet_path)
      delayed_tweet.perform
    end

    it "should tweet question" do
      question = FactoryGirl.create(:question)
      delayed_tweet = DelayedJob::Tweet.new('Question', question.id, true)
      expect(delayed_tweet).to receive(:init_twitter)
      expect(delayed_tweet).to receive(:tweet).with(question.tweet_title, question.tweet_path)
      delayed_tweet.perform
    end
  end
end
