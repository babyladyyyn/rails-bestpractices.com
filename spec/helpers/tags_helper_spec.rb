require 'spec_helper'

describe TagsHelper do
  it "should return all tags" do
    tag1 = ActsAsTaggableOn::Tag.create(:name => 'tag1')
    tag2 = ActsAsTaggableOn::Tag.create(:name => 'tag2')
    tag3 = ActsAsTaggableOn::Tag.create(:name => 'tag3')

    helper.all_tags.should == "['tag1','tag2','tag3']"
  end
end
