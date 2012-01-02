Rails.cache.logger = Rails.logger

MEMCACHE_YAML = Rails.root.join('config', 'memcache.yml')
MEMCACHE_CONFIG = YAML.load_file(MEMCACHE_YAML)[Rails.env]

RailsBestpracticesCom::Application.configure do
  config.cache_store = ActiveSupport::Cache::MemCacheStore.new(Memcached::Rails.new(MEMCACHE_CONFIG))
end
