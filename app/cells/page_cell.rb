class PageCell < Cell::Rails
  cache :sidebar, :expires_in => 1.day

  def sidebar
    body = ""

    controller = params[:controller]
    action = params[:action]
    name = "#{controller}-#{action}-sidebar"
    page1 = Page.find_cached_by_name(name)
    body += page1.body if page1

    if action == 'new' or action == 'edit'
      name = "#{controller}-form-sidebar"
    else
      name = "#{controller}-sidebar"
    end
    page2 = Page.find_cached_by_name(name)
    body += page2.body if page2

    render :text => body
  end

end
