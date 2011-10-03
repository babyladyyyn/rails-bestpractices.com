Factory.define :answer do |p|
  p.association :user
  p.association :question
  p.association :answer_body
end

Factory.define :answer_body do |ab|
  ab.body "answer"
end

Factory.define :comment do |p|
  p.association :user
  p.association :commentable, :factory => :post
  p.body '(sample comment)'
end

Factory.define :notification_setting do |n|
  n.association :user
end

Factory.define :notification do |n|
  n.association :user
  n.association :notifierable, :factory => :comment
  n.read false
end

Factory.define :page do |p|
  p.sequence(:name) {|n| "Page #{n}" }
  p.body "name\n=======\nbody\n-----"
end

Factory.define :post_body do |pb|
  pb.body "subject\n=======\ntitle\n-----"
end

Factory.define :code_post_body, :parent => :post_body do |pb|
  pb.body "subject\n=======\ntitle\n-----\n    def test\n      puts 'test'\n    end"
end

Factory.define :post do |p|
  p.sequence(:title) {|n| "Post #{n}" }
  p.association :user
  p.published true
  p.association :post_body
end

Factory.define :code_post, :parent => :post do |p|
  p.sequence(:title) {|n| "Code Post #{n}" }
  p.association :post_body, :factory => :code_post_body
end

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

Factory.define :sponsor do |s|
  s.sequence(:name) {|n| "Sponsor #{n}" }
  s.sequence(:website_url) {|n| "http://sponsor#{n}.com" }
  s.sequence(:image_url) {|n| "/images/sponsor#{n}.png" }
end

Factory.define :user do |u|
  u.sequence(:login) {|i| "user#{i}" }
  u.password {|u| u.login.size < 6 ? u.login * 2 : u.login }
  u.password_confirmation {|u| u.password }
  u.email {|u| "#{u.login}@gmail.com" }
end

Factory.define :flyerhzm, :parent => :user do |u|
  u.login "flyerhzm"
  u.password "flyerhzm"
  u.password_confirmation "flyerhzm"
  u.email "flyerhzm@gmail.com"
end

Factory.define :richard, :parent => :user do |u|
  u.login "richard"
  u.email "richard@ekohe.com"
  u.password "richard"
  u.password_confirmation "richard"
end

Factory.define :invalid_user, :class => User do |u|
end

Factory.define :vote do |p|
  p.association :user
  p.association :voteable, :factory => :post
  p.sequence(:like) {|n| [false,true][n%2] }
end
