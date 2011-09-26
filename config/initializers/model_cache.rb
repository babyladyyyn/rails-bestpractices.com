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
    cache.fetch("#{name.tableize}/#{id}") do
      find_one_without_cache(id)
    end
  end

  def find_by_attributes_with_cache(match, attributes, *args)
    cache.fetch("#{name.tableize}/#{attributes.zip(args).flatten.join('/')}/#{match.finder}") do
      find_by_attributes_without_cache(match, attributes, args)
    end
  end

  alias_method_chain :find_one, :cache
  alias_method_chain :find_by_attributes, :cache
end
