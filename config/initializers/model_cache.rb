ActiveRecord::Base.class_eval do
  def model_cache
    Rails.cache
  end

  def model_key
    "#{self.class.name.tableize}/#{self.id}"
  end

  def expire_cache
    if self.class.read_inheritable_attribute :key
      model_cache.delete model_key
    end
    if indices = self.class.read_inheritable_attribute(:indices)
      indices.each do |attribute, finders|
        finders.each do |finder|
          model_cache.delete "#{self.class.name.tableize}/#{attribute}/#{self.send(attribute)}/#{finder}"
        end
      end
    end
  end

  class <<self
    def cache_key
      write_inheritable_attribute :key, true
    end

    def cache_by_attribute(attribute)
      write_inheritable_attribute :indices, {attribute.to_s => []}
    end

    def cache_method(*methods)
      methods.each do |meth|
        class_eval <<-EOF
          def cached_#{meth}
            model_cache.fetch model_key + "/#{meth}" do
              #{meth}
            end
          end
        EOF
      end
    end
  end
end

ActiveRecord::FinderMethods.class_eval do
  def find_one_with_cache(id)
    if read_inheritable_attribute :key
      model_cache.fetch "#{name.tableize}/#{id.to_i}" do
        find_one_without_cache(id)
      end
    else
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

  alias_method_chain :find_one, :cache
  alias_method_chain :find_by_attributes, :cache
end
