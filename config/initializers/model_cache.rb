ActiveRecord::Base.class_eval do
  def model_cache
    Rails.cache
  end

  def expire_cache
    model_cache.delete "#{self.class.name.tableize}/#{self.id}"
    indices = self.class.read_inheritable_attribute(:indices)
    return unless indices
    indices.each do |attribute, finders|
      finders.each do |finder|
        model_cache.delete "#{self.class.name.tableize}/#{attribute}/#{self.send(attribute)}/#{finder}"
      end
    end
  end

  class <<self
    def index(attribute)
      write_inheritable_attribute :indices, {attribute.to_s => []}
    end
  end
end

ActiveRecord::FinderMethods.class_eval do
  def find_one_with_cache(id)
    model_cache.fetch cache_id_key(id) do
      find_one_without_cache(id)
    end
  end

  def find_by_attributes_with_cache(match, attributes, *args)
    cache_key = "#{name.tableize}/#{attributes.zip(args).flatten.join('/')}/#{match.finder}"
    model_cache.fetch(cache_key) do
      indices = read_inheritable_attribute :indices
      indices[attributes[0]] << match.finder
      write_inheritable_attribute :indices, indices
      find_by_attributes_without_cache(match, attributes, args)
    end
  end

  def model_cache
    Rails.cache
  end

  def cache_id_key(id)
    "#{name.tableize}/#{id.to_i}"
  end

  alias_method_chain :find_one, :cache
  alias_method_chain :find_by_attributes, :cache
end
