Factory.define :question do |q|
  q.sequence(:title) {|n| "Question #{n}" }
  q.association :user
end

Factory.define :question_body do |qb|
  qb.body "subject\n=======\ntitle\n-----"
end

Factory.define :code_question, :parent => :question do |q|
  q.sequence(:title) {|n| "Code Question #{n}" }
  q.association :user
end

Factory.define :code_question_body, :parent => :question_body do |qb|
  qb.body "subject\n=======\ntitle\n-----\n    def test\n      puts 'test'\n    end"
end
