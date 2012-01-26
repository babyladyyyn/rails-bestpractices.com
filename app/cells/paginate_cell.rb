class PaginateCell < Cell::Rails
  cache :show, :if => lambda { |cell, collection, name=nil| collection.present? } do |cell, collection, name=nil|
    "#{collection.first.model_cache_key}/#{cell.params[:page] || 1}"
  end

  def show(collection, name=nil)
    if collection.present?
      @collection = collection
      @name = name || "page"
      render
    end
  end

end
