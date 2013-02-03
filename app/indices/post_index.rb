ThinkingSphinx::Index.define :post, :with => :active_record do
  indexes title, description
  indexes post_body.body, :as => :body

  has id

  set_property :field_weights => {
    :title       => 10,
    :description => 5,
    :body        => 1
  }

  where sanitize_sql(["published", true])
end
