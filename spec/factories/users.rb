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
