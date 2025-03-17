require 'kafka'

class JobEventConsumer < Racecar::Consumer
  subscribes_to 'job_events' # Lắng nghe sự kiện từ Kafka topic "job_events"

  # Cấu hình Kafka broker
  Racecar.configure do |config|
    racecar_config = YAML.load_file(Rails.root.join('config', 'racecar.yml'))

    # Xác định môi trường (development, test, production)
    env_config = racecar_config[Rails.env] || {}

    # Thiết lập brokers và client_id từ file YAML
    config.brokers = env_config['brokers'] || ['localhost:9092']
    config.client_id = env_config['client_id'] || 'default-client'
  end

  def process(message)
    event_data = JSON.parse(message.value)
    event_type = message.key

    # Đẩy vào Redis Pub/Sub
    REDIS.publish('notifications', { event: event_type, data: event_data }.to_json)

    puts "📩 Received Kafka event: #{message.value}"
  end
end
