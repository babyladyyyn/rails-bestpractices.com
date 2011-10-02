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
      class_eval <<-EOF
        after_update :expire_key_cache

        def self.find_cached(id)
          Rails.cache.fetch "#{name.tableize}" + id.to_s do
            self.find(id)
          end
        end
      EOF
    end

    def with_attribute(*attributes)
      indices = attributes.inject({}) { |indices, attribute| indices[attribute.to_s] = []; indices }
      write_inheritable_attribute :indices, indices
      attributes.each do |attribute|
        class_eval <<-EOF
          def self.find_cached_by_#{attribute}(value)
            Rails.cache.fetch "#{name.tableize}/#{attribute}/" + value.to_s do
              self.find_by_#{attribute}(value)
            end
          end
        EOF
      end
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
