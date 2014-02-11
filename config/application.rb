require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env)

module RailsBestpracticesCom
  class Application < Rails::Application
    config.app_generators do |g|
      g.template_engine :haml
      g.test_framework :rspec, :fixture => false, :views => false
      g.fixture_replacement :factory_girl
    end

    config.autoload_paths += %W( #{config.root}/lib #{config.root}/app/workers )

    config.i18n.default_locale = :en

    config.encoding = "utf-8"

    config.assets.enabled = true
    config.assets.version = '1.0'
    config.assets.paths << Rails.root.join("vendor", "assets", "components")

    MEMCACHE_CONFIG = YAML.load_file(Rails.root.join('config', 'memcache.yml'))[Rails.env]
    config.cache_store = Memcached::Rails.new(MEMCACHE_CONFIG.symbolize_keys.merge(:logger => Rails.logger))
  end
end
