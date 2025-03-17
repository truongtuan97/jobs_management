require 'kafka'

class KafkaProducer  
  def self.kafka_client
    racecar_config = YAML.load_file(Rails.root.join('config', 'racecar.yml'))
    # Xác định môi trường (development, test, production)
    env_config = racecar_config[Rails.env] || {}

    @kafka_client ||= Kafka.new(env_config['brokers'], client_id: env_config['client_id'])
  end

  def self.publish(topic, message)
    kafka_client.deliver_message(message.to_json, topic: topic)

    puts "✅ Sent message to Kafka topic: #{topic}"
  end
end
