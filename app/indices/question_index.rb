ThinkingSphinx::Index.define :question, :with => :active_record do
  indexes title
  indexes question_body.body, :as => :body

  has :id

  set_property :field_weights => {
    :title => 10,
    :body  => 1
  }
end
