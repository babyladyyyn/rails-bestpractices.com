class NotifyJobWorker
  include Sidekiq::Worker

  def perform(job_id)
    job = Job.find(job_id)
    NotificationMailer.notify_job(job).deliver
  end
end
