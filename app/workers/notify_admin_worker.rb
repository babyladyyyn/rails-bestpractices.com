class NotifyAdminWorker
  include Sidekiq::Worker

  def perform(post_id)
    post = Post.find_cached(post_id)
    NotificationMailer.notify_admin(post).deliver
  end
end
