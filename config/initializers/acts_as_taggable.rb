module ActsAsTaggableOn
  class Tag
    scope :important_tags, where(['important = ?', true])
    
    def posts
      Post.tagged_with(self.name)
    end

    def questions
      Question.tagged_with(self.name)
    end
  end
end
