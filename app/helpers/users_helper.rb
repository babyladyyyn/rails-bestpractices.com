module UsersHelper
  def user_link(user)
    if user.url
      link_to user.login, user.url, :target => '_blank'
    else
      content_tag :span, user.login
    end
  end

  def default_gravatar(size = 32)
    image_tag "http://gravatar.com/avatar/b642b4217b34b1e8d3bd915fc65c4452.png?d=mm&r=PG&s=#{size}", :class => 'user-avatar', :alt => 'anonymous'
  end

  def comment_avatar(comment)
    if comment.cached_user
      image_tag comment.cached_user.gravatar_url(:size => 32, :default => 'mm'), :class => 'user-avatar', :alt => comment.cached_user.login
    else
      default_gravatar
    end
  end

  def statistic_command
    command =<<-EOF
    <div class='command'>
    #{link_to('Collapse', '#', :class => 'collapse minus-sign-icon')}
    #{link_to('Expand', '#', :class => 'expand plus-sign-icon hide')}
    </div>
    EOF
    command.html_safe
  end
end
