Factory.define :sponsor do |s|
  s.sequence(:name) {|n| "Sponsor #{n}" }
  s.sequence(:website_url) {|n| "http://sponsor#{n}.com" }
  s.sequence(:image_url) {|n| "/images/sponsor#{n}.png" }
end
