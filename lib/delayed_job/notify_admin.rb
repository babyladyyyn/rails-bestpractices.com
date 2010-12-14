class DelayedJob::NotifyAdmin < Struct.new(:post_id)
  def perform
    post = Post.find(post_id)
    NotificationMailer.notify_admin(post).deliver
  end
end
