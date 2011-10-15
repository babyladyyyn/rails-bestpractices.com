class TagCell < Cell::Rails
  cache :important, :expires_in => 1.day, :if => :available

  def important
    if available
      @tags = ActsAsTaggableOn::Tag.important_tags.order("name asc")
      render
    end
  end

  private
    def available
      %w(posts questions commments tags search).include? params[:controller]
    end

end
