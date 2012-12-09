class PaginateCell < Cell::Rails
  def show(collection, name=nil)
    if collection.present?
      @collection = collection
      @name = name || "page"
      render
    end
  end
end
