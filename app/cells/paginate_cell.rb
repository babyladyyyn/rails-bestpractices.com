class PaginateCell < Cell::Rails
  cache :show do |cell, collection|
    "#{collection.first.model_cache_key}/paginate/#{cell.params[:page] || 1}/show"
  end

  def show(collection, name=nil)
    @collection = collection
    @name = name || "page"
    render
  end

end
