class JobMailer < ApplicationMailer
  default from: 'no-reply@jobportal.com'

  def new_job_notification(job)
    @job = job
    user_emails = User.pluck(:email)

    mail(
      to: user_emails,
      subject: "New Job Posted: #{job.title}"
    )
  end
end
