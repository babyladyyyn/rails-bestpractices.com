class TagCell < Cell::Rails
  cache :important, :expires_in => 1.day, :if => proc { |cell, name| available(name) }

  def important(name)
    if available(name)
      @tags = ActsAsTaggableOn::Tag.important_tags.order("name asc")
      render
    end
  end

  def list(parent)
    @tags = parent.cached_tags
    render
  end

  private
    def available(name)
      %w(posts questions commments tags search).include? name
    end

end
