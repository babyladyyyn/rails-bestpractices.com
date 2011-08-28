class DelayedJob::Tweet < Struct.new(:klass_name, :id, :force)
  def perform
    if Rails.env.production? || force
      model = klass_name.constantize.find(id)
      tweet(model.tweet_title, model.tweet_path)
    end
  end

  def tweet(title, path)
    url = bitly.shorten("http://rails-bestpractices.com/#{path}").short_url
    Twitter.update("#{title} #{url} #railsbp")
  end

  def twitter
    omniauth_config = OMNIAUTH_CONFIG['twitter']
    twitter_user = User.find_by_login("Rails BestPractices")
    provider = twitter_user.authentications.find_by_provider('twitter')
    Twitter.configure do |config|
      config.consumer_key = omniauth_config['key']
      config.consumer_secret = omniauth_config['secret']
      config.oauth_token = provider.token
      config.oauth_token_secret = provider.secret
    end
  end

  def bitly
    config = BITLY_CONFIG
    Bitly.new(config['username'], config['api_key'])
  end
end
