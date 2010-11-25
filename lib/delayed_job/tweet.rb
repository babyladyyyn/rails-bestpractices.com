class DelayedJob::Tweet < Struct.new(:klass_name, :id)
  def perform
    model = klass_name.constantize.find(id)
    tweet(model.tweet_title, model.tweet_path)
  end

  def tweet(title, path)
    url = bitly.shorten("http://rails-bestpractices.com/#{path}").short_url
    twitter.update("#{title} #{url} #railsbp")
  end

  def twitter
    config = TWITTER_CONFIG
    twitter_user = User.find_by_login("Rails BestPractices")
    oauth = Twitter::OAuth.new(config['key'], config['secret'])
    oauth.authorize_from_access(twitter_user.access_token.token, twitter_user.access_token.secret)
    Twitter::Base.new(oauth)
  end

  def bitly
    config = BITLY_CONFIG
    Bitly.new(config['username'], config['api_key'])
  end
end
