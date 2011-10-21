class TagCell < Cell::Rails
  cache :list do |cell, parent|
    "#{parent.cache_key}/tag/list"
  end

  def list(parent)
    @tags = parent.tags
    render
  end

end
