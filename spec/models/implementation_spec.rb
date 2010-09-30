require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe Implementation do

  include RailsBestPractices::Spec::Support
  should_be_markdownable
  should_be_user_ownable
  should_have_entries_per_page 10

  should_be_tweetable do |implementation|
    {
      :title => "Implementation of #{implementation.post.title}",
      :path => "posts/#{implementation.post.to_param}/implementation"
    }
  end

  should_belong_to :post, :touch => true
  should_validate_presence_of :body

  context "implemented" do
    it "set implementd for post" do
      post = Factory(:post)
      post.implemented.should == false
      implementation = Factory(:implementation, :post => post)
      post.implemented.should == true
    end
  end

end
