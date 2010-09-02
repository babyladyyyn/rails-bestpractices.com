TWITTER_YAML = Rails.root.join('config', 'authlogic.yml')
TWITTER_CONFIG = YAML.load_file(TWITTER_YAML)['connect']['twitter']

BITLY_YAML = Rails.root.join('config', 'bitly.yml')
BITLY_CONFIG = YAML.load_file(BITLY_YAML)[Rails.env]
