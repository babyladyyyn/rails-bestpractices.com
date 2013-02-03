ThinkingSphinx::Index.define :post, :with => :active_record do
  indexes title, description
  indexes post_body.body, :as => :body
  indexes user.articles.title, :as => :related_titles

  has id

  set_property :field_weights => {
    :title       => 10,
    :description => 5,
    :body        => 1
  }

  where "published = 1"
end
