class SidebarCell < Cell::Rails
  cache :display, :expires_in => 1.day do |cell, controller, action, user|
    "#{controller}/#{action}/#{!!user}"
  end

  cache :login
  cache :links
  cache :referrals, :expires_in => 1.day
  cache :jobs, :expires_in => 1.day
  cache :posts_navigation
  cache :blog_rss
  cache :recent_blog_posts, :expires_in => 1.day
  cache :important_tags, :expires_in => 1.day

  def display(controller="posts", action="index", user=nil)
    sidebar = []
    unless user
      sidebar << render(:state => :login)
    end
    sidebar << render(:state => :referrals)
    sidebar << render(:state => :jobs)
    case controller
    when "posts", "comments"
      sidebar << render(:state => :posts_navigation)
    when "blog_posts"
      sidebar << render(:state => :blog_rss)
      sidebar << render(:state => :recent_blog_posts)
    else
    end
    sidebar << render({:state => :dynamic_sidebar}, controller, action)
    if %w(posts questions commments tags search).include? controller
      sidebar << render(:state => :important_tags)
    end
    sidebar.join('').html_safe
  end

  def login
    render
  end

  def referrals
    render
  end

  def jobs
    @jobs = Job.published.order("created_at desc").limit(5)
    render
  end

  def posts_navigation
    render
  end

  def blog_rss
    render
  end

  def recent_blog_posts
    @recent_blog_posts = BlogPost.order("created_at desc").select("id, title").limit(5)
    render
  end

  def dynamic_sidebar(controller, action)
    body = ""

    name = "#{controller}-#{action}-sidebar"
    page1 = Page.find_cached_by_name(name)
    body += page1.body if page1

    if action == 'new' || action == 'edit'
      name = "#{controller}-form-sidebar"
    else
      name = "#{controller}-sidebar"
    end
    page2 = Page.find_cached_by_name(name)
    body += page2.body if page2

    body
  end

  def important_tags
    @tags = ActsAsTaggableOn::Tag.important_tags.order("name asc")
    render
  end

end
