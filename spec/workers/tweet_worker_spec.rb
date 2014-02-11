require "spec_helper"

describe TweetWorker do

  describe "perform" do
    it "should tweet post" do
      post = FactoryGirl.create(:post)
      delayed_tweet = TweetWorker.new
      expect(delayed_tweet).to receive(:init_twitter)
      expect(delayed_tweet).to receive(:tweet).with(post.tweet_title, post.tweet_path)
      delayed_tweet.perform('Post', post.id, true)
    end

    it "should tweet question" do
      question = FactoryGirl.create(:question)
      delayed_tweet = TweetWorker.new
      expect(delayed_tweet).to receive(:init_twitter)
      expect(delayed_tweet).to receive(:tweet).with(question.tweet_title, question.tweet_path)
      delayed_tweet.perform('Question', question.id, true)
    end
  end
end
