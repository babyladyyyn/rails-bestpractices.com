class DelayedJob::NotifyComment < Struct.new(:comment_id)
  def perform
    comment = Comment.find(comment_id)
    commentable = comment.commentable
    emails = []

    unless commentable.user == comment.user
      emails << commentable.user.email
      NotificationMailer.notify_comment(commentable.user.email, comment)
    end

    comments = commentable.comments
    comments.each do |c|
      if c.email and c.email != comment.email and !emails.include? c.email
        emails << c.email
        NotificationMailer.notify_comment(c.email, comment)
      end
    end
  end
end
