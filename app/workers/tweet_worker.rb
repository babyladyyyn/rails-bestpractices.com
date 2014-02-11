class TweetWorker
  include Sidekiq::Worker

  def perform(klass_name, id, force)
    if Rails.env.production? || force
      config = BITLY_CONFIG
      bitly = Bitly.new(config['username'], config['api_key'])

      omniauth_config = OMNIAUTH_CONFIG['twitter']
      twitter_user = User.find_cached(omniauth_config["user_id"])
      provider = twitter_user.authentications.find_by_provider('twitter')
      Twitter.configure do |config|
        config.consumer_key = omniauth_config['key']
        config.consumer_secret = omniauth_config['secret']
        config.oauth_token = provider.token
        config.oauth_token_secret = provider.secret
      end

      model = klass_name.constantize.find_cached(id)
      url = bitly.shorten("http://rails-bestpractices.com/#{model.tweet_path}").short_url
      Twitter.update("#{model.tweet_title} #{url} #railsbp")
    end
  end
end
