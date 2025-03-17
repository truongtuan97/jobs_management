require 'kafka'

class JobEventConsumer < Racecar::Consumer
  subscribes_to 'job_events' # Lắng nghe sự kiện từ Kafka topic "job_events"

  # Cấu hình Kafka broker
  Racecar.configure do |config|
    config.brokers = ["kafka:9092"]  # Thay vì 127.0.0.1:9092
  end
  
  def process(message)
    event_data = JSON.parse(message.value)
    event_type = message.key

    # Đẩy vào Redis Pub/Sub
    REDIS.publish("notifications", { event: event_type, data: event_data }.to_json)

    puts "📩 Received Kafka event: #{message.value}"
  end
end
