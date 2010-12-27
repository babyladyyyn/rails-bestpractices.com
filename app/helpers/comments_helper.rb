module CommentsHelper
  def comment_user_link(comment)
    if comment.user
      link_to comment.user.login, user_path(comment.user)
    else
      comment.username
    end
  end

  def comment_parent_link(comment)
    commentable = comment.commentable
    case commentable
    when Post
      post_url(commentable)
    when Question
      question_url(commentable)
    when Answer
      question_url(commentable.question)
    when BlogPost
      blog_post_path(commentable)
    end
  end

  def comment_statistics(comment)
    commentable = comment.commentable
    case commentable
    when Post
      <<-EOF
        <p>#{commentable.vote_points} votes</p>
        <p>#{commentable.comments_count} comments</p>
        <p>#{commentable.view_count} views</p>
      EOF
    when Question
      <<-EOF
        <p>#{commentable.vote_points} votes</p>
        <p>#{commentable.answers_count} answers</p>
        <p>#{commentable.comments_count} views</p>
        <p>#{commentable.view_count} views</p>
      EOF
    when Answer
      <<-EOF
        <p>#{commentable.vote_points} votes</p>
        <p>#{commentable.comments_count} views</p>
      EOF
    when BlogPost
      <<-EOF
        <p>#{commentable.comments_count} views</p>
      EOF
    end.html_safe
  end
end
