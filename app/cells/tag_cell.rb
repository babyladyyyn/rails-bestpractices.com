class TagCell < Cell::Rails
  cache :list do |cell, parent|
    parent.model_cache_key
  end

  def list(parent)
    @tags = parent.tags
    render
  end

end
