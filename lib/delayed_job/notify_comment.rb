class DelayedJob::Notification < Struct.new(:notifier_method, :object, :user_id)
  def perform
    NotificationMailer.send(notifer_method).deliver, object, user_id)
  end
end
