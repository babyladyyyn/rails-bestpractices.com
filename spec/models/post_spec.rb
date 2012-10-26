require 'spec_helper'

describe Post do

  let(:post) { Factory.create(:post) }

  include RailsBestPractices::Spec::Support
  should_be_taggable
  should_be_user_ownable
  should_be_voteable

  should_be_tweetable do |post|
    {
      :title => post.title,
      :path => "posts/#{post.to_param}"
    }
  end

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

  describe 'when title validation is required' do
    before { Factory.create(:post) }
    it { should validate_presence_of(:title) }
    it { should validate_uniqueness_of(:title) }
  end

  it 'should be scopable by implemented posts' do
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

    it "should increment user.posts_count" do
      origin_posts_count = @post.cached_user.posts_count
      @post.publish!
      @post.reload
      @post.cached_user.posts_count.should == origin_posts_count + 1
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

  context "prev" do
    before :each do
      @post1 = Factory(:post, :vote_points => 20)
      @post2 = Factory(:post, :vote_points => 10, :implemented => true)
    end

    it "should order by id" do
      @post1.prev("id").should be_nil
      @post2.prev("id").should == @post1
    end

    it "should order by vote_points" do
      @post1.prev("vote_points").should == @post2
      @post2.prev("vote_points").should be_nil
    end

    it "should order by implemented" do
      @post3 = Factory(:post, :implemented => true)
      @post2.prev("implemented").should be_nil
      @post3.prev("implemented").should == @post2
    end
  end

  context "next" do
    before :each do
      @post1 = Factory(:post, :vote_points => 20, :implemented => true)
      @post2 = Factory(:post, :vote_points => 10, :implemented => true)
    end

    it "should order by id" do
      @post1.next("id").should == @post2
      @post2.next("id").should be_nil
    end

    it "should order by vote_points" do
      @post1.next("vote_points").should be_nil
      @post2.next("vote_points").should == @post1
    end

    it "should order by implemented" do
      @post3 = Factory(:post)
      @post1.next("implemented").should == @post2
      @post2.next("implemented").should be_nil
    end
  end
end
