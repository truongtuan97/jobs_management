class JobNotificationJob < ApplicationJob
  queue_as :default

  def perform(job_id)
    job = Job.find(job_id)
    return unless job
    
    JobMailer.new_job_notification(job).deliver_now
  end
end