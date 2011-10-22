class DelayedJob::NotifyComment < Struct.new(:comment_id)
  def perform
    comment = Comment.find_cached(comment_id)
    commentable = comment.cached_commentable
    emails = []

    email = commentable.cached_user.email
    if comment.commentable_type == "BlogPost"
      NotificationMailer.notify_comment(email, comment).deliver
    elsif email.present? and commentable.cached_user != comment.cached_user
      emails << email
      NotificationMailer.notify_comment(email, comment).deliver if commentable.cached_user.send("comment_#{comment.commentable_type.underscore}?")
    end

    comments = commentable.comments
    comments.each do |c|
      email = c.user_email
      if email.present? and email != comment.user_email and !emails.include? email
        emails << email
        NotificationMailer.notify_comment(email, comment).deliver if commentable.cached_user.send("after_#{comment.commentable_type.underscore}_comment?")
      end
    end
  end
end
