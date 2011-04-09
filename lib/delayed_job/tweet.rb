class DelayedJob::Tweet < Struct.new(:klass_name, :id, :force)
  def perform
    if Rails.env.production? || force
      model = klass_name.constantize.find(id)
      tweet(model.tweet_title, model.tweet_path)
    end
  end

  def tweet(title, path)
    url = bitly.shorten("http://rails-bestpractices.com/#{path}").short_url
    twitter.update("#{title} #{url} #railsbp")
  end

  def twitter
    config = OMNIAUTH_CONFIG['twitter']
    twitter_user = User.find_by_login("Rails BestPractices")
    provider = twitter_user.authentications.find_by_provider('twitter')
    oauth = Twitter::OAuth.new(config['key'], config['secret'])
    oauth.authorize_from_access(provider.token, provider.secret)
    Twitter::Base.new(oauth)
  end

  def bitly
    config = BITLY_CONFIG
    Bitly.new(config['username'], config['api_key'])
  end
end
