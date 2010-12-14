require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe Post do

  let(:post) { Factory.create(:post) }

  include RailsBestPractices::Spec::Support
  should_act_as_taggable
  should_be_markdownable
  should_be_user_ownable
  should_be_commentable
  should_be_voteable
  should_have_entries_per_page 10

  should_be_tweetable do |post|
    {
      :title => post.title,
      :path => "posts/#{post.to_param}"
    }
  end

  should_have_one :implementation, :dependent => :destroy
  should_validate_presence_of :body

  describe 'when title validation is required' do
    before { Factory.create(:post) }
    should_validate_presence_of :title
    should_validate_uniqueness_of :title
  end

  it 'should be scopable by completed implementation' do
    Post.delete_all
    posts = [false, true].map{|flag| Factory(:post, :implemented => flag) }
    Post.implemented.should == posts[1..1]
  end

  it 'should be scopable by published posts' do
    Post.delete_all
    posts = [false, true].map{|flag| Factory(:post, :published => flag) }
    Post.published.should == posts[1..1]
  end

  it "should reflect :id & :title when converted to param" do
    post.title = 'Super Mighty Proc'
    post.to_param.should == post.instance_exec{"#{id}-#{title.parameterize}"}
  end

  it "should notify admin after create" do
    Delayed::Job.should_receive(:enqueue)
    Factory(:post)
  end

  context "publish!" do
    before :each do
      @post = Factory(:post, :published => false)
    end

    it "should mark published as true" do
      @post.publish!
      @post.should be_published
    end

    it "should tweet after publish!" do
      Delayed::Job.should_receive(:enqueue)
      @post.publish!
    end
  end

end
