module Mutations
  class CreateJob < Mutations::BaseMutation
    argument :title, String, required: true
    argument :salary, Float, required: true
    argument :company_id, ID, required: true
    argument :description, ID, required: true
    argument :user_id, ID, required: true

    field :job, Types::JobType, null: true
    field :errors, [String], null: false

    def resolve(company_id:, title:, salary:, user_id:, description:)
      company = Company.find_by(id: company_id)
      return { job: nil, errors: ["Company not found"] } unless company

      user = User.find_by(id: user_id)
      return { job: nil, errors: ["User not found"] } unless user

      job = company.jobs.build(title: title, salary: salary, description: description, user_id: user_id)

      if job.save
        JobNotificationJob.perform_later(job.id) # Gửi job lên Sidekiq
        { job: job, errors: [] }
      else
        { job: nil, errors: job.errors.full_messages }
      end
    end
    
  end
end
