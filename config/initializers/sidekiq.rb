redis_config = YAML.load_file(Rails.root.join('config', 'redis.yml'))[Rails.env]

Sidekiq.configure_server do |config|
  config.redis = { :url => redis_config['url'], :namespace => redis_config['namespace'] }
end

Sidekiq.configure_client do |config|
  config.redis = { :url => redis_config['url'], :namespace => redis_config['namespace'] }
end
