require 'kafka'

class KafkaProducer
  def self.kafka_client
    @kafka_client ||= Kafka.new(['18.141.20.90:9092'], client_id: 'rails-app')
  end

  def self.publish(topic, message)
    kafka_client.deliver_message(message.to_json, topic: topic)

    puts "✅ Sent message to Kafka topic: #{topic}"
  end
end
