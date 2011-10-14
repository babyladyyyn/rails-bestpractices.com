module UsersHelper
  def user_link(user)
    if user.url
      link_to user.login, user.url, :target => '_blank'
    else
      content_tag :span, user.login
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
