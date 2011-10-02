ActiveRecord::Base.class_eval do
  def model_key
    "#{self.class.name.tableize}/#{self.id}"
  end

  def expire_cache
    expire_key_cache
    expire_attribute_cache
    expire_method_cache
  end

  def expire_key_cache
    Rails.cache.delete model_key
  end

  def expire_attribute_cache
    Array(self.class.read_inheritable_attribute(:indices)).each do |attribute, finders|
      finders.each do |finder|
        Rails.cache.delete "#{self.class.name.tableize}/#{attribute}/#{self.send(attribute)}/#{finder}"
      end
    end
  end

  def expire_method_cache
    Array(self.class.read_inheritable_attribute(:methods)).each do |meth|
      Rails.cache.delete "#{self.class.name.tableize}/#{self.id}/#{meth}"
    end
  end

  class <<self
    def model_cache(&block)
      instance_exec &block
    end

    def with_key
      write_inheritable_attribute :key, true
      class_eval <<-EOF
        after_update :expire_key_cache
      EOF
    end

    def with_attribute(*attributes)
      indices = attributes.inject({}) { |indices, attribute| indices[attribute.to_s] = []; indices }
      write_inheritable_attribute :indices, indices
      class_eval <<-EOF
        after_update :expire_attribute_cache
      EOF
    end

    def with_method(*methods)
      write_inheritable_attribute :methods, methods
      methods.each do |meth|
        class_eval <<-EOF
          def cached_#{meth}
            Rails.cache.fetch model_key + "/#{meth}" do
              #{meth}
            end
          end
        EOF
      end
      class_eval <<-EOF
        after_update :expire_method_cache
      EOF
    end
  end
end

ActiveRecord::FinderMethods.class_eval do
  def find_one_with_cache(id)
    if read_inheritable_attribute :key
      Rails.cache.fetch "#{name.tableize}/#{id.to_i}" do
        find_one_without_cache(id)
      end
    else
      find_one_without_cache(id)
    end
  end

  def find_by_attributes_with_cache(match, attributes, *args)
    if indices = read_inheritable_attribute(:indices)
      cache_key = "#{name.tableize}/#{attributes.zip(args).flatten.join('/')}/#{match.finder}"
      Rails.cache.fetch(cache_key) do
        indices[attributes[0]] << match.finder
        write_inheritable_attribute :indices, indices
        find_by_attributes_without_cache(match, attributes, args)
      end
    else
      find_by_attributes_without_cache(match, attributes, args)
    end
  end

  alias_method_chain :find_one, :cache
  alias_method_chain :find_by_attributes, :cache
end
