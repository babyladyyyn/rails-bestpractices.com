Factory.define :answer do |p|
  p.association :user
  p.association :question
  p.association :answer_body
end

Factory.define :answer_body do |ab|
  ab.body "answer"
end
