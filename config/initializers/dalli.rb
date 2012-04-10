MEMCACHE_YAML = Rails.root.join('config', 'memcache.yml')
MEMCACHE_CONFIG = YAML.load_file(MEMCACHE_YAML)[Rails.env]

RailsBestpracticesCom::Application.configure do
  config.cache_store = :dalli_store, *MEMCACHE_CONFIG.delete("hosts"), MEMCACHE_CONFIG
end

if defined?(PhusionPassenger)
  PhusionPassenger.on_event(:starting_worker_process) do |forked|
    # Reset Rails's object cache
    # Only works with DalliStore
    Rails.cache.reset if forked

    # Reset Rails's session store
    # If you know a cleaner way to find the session store instance, please let me know
    ObjectSpace.each_object(ActionDispatch::Session::DalliStore) { |obj| obj.reset }
  end
end
