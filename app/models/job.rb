class Job < ApplicationRecord
  belongs_to :user
  belongs_to :company
  has_many :applications, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validates :salary, numericality: { greater_than: 0 }

  after_create :publish_event_to_kafka
  after_update :log_changes

  def self.cached_jobs
    jobs = REDIS.get('jobs')

    if jobs.nil?
      jobs = Job.includes(:company).all.to_json
      REDIS.set('jobs', jobs)
      REDIS.expire('jobs', 5.minutes.to_i)
    end

    JSON.parse(jobs)
  end

  private

  def publish_event_to_kafka
    # KafkaProducer.publish('job_events', { id: id, title: title, created_at: created_at })
    JobEventProducer.publish('job_created', { id: id, title: title, created_at: created_at })
  end

  def log_changes
    AuditLog.create!(
      action: 'update',
      user_id: user.id,
      details: previous_changes,
      created_at: Time.current
    )
  end
end
