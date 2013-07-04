module ActsAsTaggableOn
  class Tag
    include Cacheable

    scope :important_tags, -> { where(['important = ?', true]) }

    model_cache do
      with_attribute :name
    end

    def posts
      Post.tagged_with(self.name)
    end

    def questions
      Question.tagged_with(self.name)
    end
  end
end
