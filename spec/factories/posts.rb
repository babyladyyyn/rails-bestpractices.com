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
