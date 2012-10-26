FactoryGirl.define do
  factory :answer do
    association :user
    association :question
    association :answer_body
  end

  factory :answer_body do
    body "answer"
  end

  factory :notification_setting do
    association :user
  end

  factory :notification do
    association :user
    association :notifierable, :factory => :answer
    read false
  end

  factory :page do
    sequence(:name) {|n| "Page #{n}" }
    body "name\n=======\nbody\n-----"
  end

  factory :post_body do
    body "subject\n=======\ntitle\n-----"
  end

  factory :code_post_body, :parent => :post_body do
    body "subject\n=======\ntitle\n-----\n    def test\n      puts 'test'\n    end"
  end

  factory :post do
    sequence(:title) {|n| "Post #{n}" }
    description "description"
    association :user
    published true
    association :post_body
  end

  factory :code_post, :parent => :post do
    sequence(:title) {|n| "Code Post #{n}" }
    association :post_body, :factory => :code_post_body
  end

  factory :question do
    sequence(:title) {|n| "Question #{n}" }
    association :user
  end

  factory :question_body do
    body "subject\n=======\ntitle\n-----"
  end

  factory :code_question, :parent => :question do
    sequence(:title) {|n| "Code Question #{n}" }
    association :user
  end

  factory :code_question_body, :parent => :question_body do
    body "subject\n=======\ntitle\n-----\n    def test\n      puts 'test'\n    end"
  end

  factory :sponsor do
    sequence(:name) {|n| "Sponsor #{n}" }
    sequence(:website_url) {|n| "http://sponsor#{n}.com" }
    sequence(:image_url) {|n| "/images/sponsor#{n}.png" }
  end

  factory :user do
    sequence(:login) {|i| "user#{i}" }
    password {|u| u.login.size < 6 ? u.login * 2 : u.login }
    password_confirmation {|u| u.password }
    email {|u| "#{u.login}@gmail.com" }
  end

  factory :flyerhzm, :parent => :user do
    login "flyerhzm"
    password "flyerhzm"
    password_confirmation "flyerhzm"
    email "flyerhzm@gmail.com"
  end

  factory :richard, :parent => :user do
    login "richard"
    email "richard@ekohe.com"
    password "richard"
    password_confirmation "richard"
  end

  factory :invalid_user, :class => User do
  end

  factory :vote do
    association :user
    association :voteable, :factory => :post
    sequence(:like) {|n| [false,true][n%2] }
  end

  factory :blog_post do
    sequence(:title) {|n| "Post #{n}" }
    sequence(:body) {|n| "post body #{n}" }
    association :user
  end

  factory :job do
    sequence(:title) {|n| "Job #{n}" }
    sequence(:company) {|n| "Company #{n}" }
    sequence(:country) {|n| "Country #{n}" }
    sequence(:city) {|n| "City #{n}" }
    sequence(:description) {|n| "Description #{n}" }
    sequence(:apply_email) {|n| "company#{n}@test.com" }
    association :user
  end

  factory :job_partner do
    sequence(:name) {|n| "www.partner#{n}.com" }
    sequence(:token) {|n| "token#{n}" }
  end

  factory :tag, :class => ActsAsTaggableOn::Tag do
    sequence(:name) {|n| "tag #{n}" }
  end
end
