class DelayedJob::NotifyJob < Struct.new(:job_id)
  def perform
    job = Job.find(job_id)
    NotificationMailer.notify_admin(job).deliver
  end
end
