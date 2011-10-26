class PaginateCell < Cell::Rails
  cache :show, :if => proc { |cell, collection| collection.total_pages > 1 && collection.size > 0 } do |cell, collection|
    "#{collection.first.model_cache_key}/#{cell.params[:page] || 1}"
  end

  def show(collection, name=nil)
    if collection.total_pages > 1
      @collection = collection
      @name = name || "page"
      render
    end
  end

end
