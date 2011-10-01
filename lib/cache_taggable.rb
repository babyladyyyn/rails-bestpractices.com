module CacheTaggable
  def self.included(base)
    base.class_eval do
      acts_as_taggable

      def tag_list
        attributes["cached_tag_list"]
      end
    end
  end
end
