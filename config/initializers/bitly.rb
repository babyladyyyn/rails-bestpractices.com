BITLY_YAML = Rails.root.join('config', 'bitly.yml')
BITLY_CONFIG = YAML.load_file(BITLY_YAML)[Rails.env]
