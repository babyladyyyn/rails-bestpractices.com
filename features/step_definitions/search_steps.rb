Given /^the (\w+) indexes are processed$/ do |model|
  model = model.classify.constantize
  ThinkingSphinx::Test.index *model.sphinx_index_names
  sleep(0.2)
end
