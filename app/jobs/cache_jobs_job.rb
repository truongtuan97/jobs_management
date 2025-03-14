class CacheJobsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Rails.cache.write("jobs_list", Job.includes(:company).all.to_json, expires_in: 10.minutes)
    REDIS.set('jobs_list', Job.includes(:company).all.to_json, ex: 5.minutes)
    puts "Updated jobs cache successfully!"
  end
end
