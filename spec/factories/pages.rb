Factory.define :page do |p|
  p.sequence(:name) {|n| "Page #{n}" }
  p.body "name\n=======\nbody\n-----"
end
