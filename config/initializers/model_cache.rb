ActiveRecord::Base.class_eval do
  def cache
    Rails.cache
  end
end

ActiveRecord::FinderMethods.class_eval do
  def cache
    Rails.cache
  end

  def find_one_with_cache(id)
    cache.fetch(cache_key(id)) do
      find_one_without_cache(id)
    end
  end

  def cache_key(id)
    "#{name.tableize}/#{id}"
  end

  alias_method_chain :find_one, :cache
end
