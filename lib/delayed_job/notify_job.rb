class DelayedJob::NotifyJob < Struct.new(:job_id)
  def perform
    job = Job.find(job_id)
    NotificationMailer.notify_job(job).deliver
  end
end
