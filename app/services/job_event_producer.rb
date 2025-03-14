require 'racecar'

class JobEventProducer
  def self.publish(_event, payload)
    # producer = Racecar::Producer.new
    # puts "---------- #{producer.inspect} ---------"
    # producer.produce(payload.to_json, topic: "job_events", key: event)
    # producer.deliver_messages
    Racecar.config.brokers = Rails.application.config_for(:racecar)[:brokers]
    Racecar.config.client_id = Rails.application.config_for(:racecar)[:client_id]

    Racecar.produce_sync(value: payload.to_json, topic: 'job_events')
  end
end
