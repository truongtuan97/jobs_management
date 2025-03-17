require 'yaml'

Racecar.configure do |config|
  # Load file racecar.yml
  racecar_config = YAML.load_file(Rails.root.join('config', 'racecar.yml'))

  # Xác định môi trường (development, test, production)
  env_config = racecar_config[Rails.env] || {}

  # Thiết lập brokers và client_id từ file YAML
  config.brokers = env_config['brokers'] || ['18.141.20.90:9092']
  config.client_id = env_config['client_id'] || 'default-client'
end
