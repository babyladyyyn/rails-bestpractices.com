require 'spec_helper'

describe Post do

  let(:post) { FactoryGirl.create(:post) }

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
    before { FactoryGirl.create(:post) }
    it { should validate_presence_of(:title) }
    it { should validate_uniqueness_of(:title) }
  end

  it 'should be scopable by implemented posts' do
    Post.delete_all
    posts = [false, true].map{|flag| FactoryGirl.create(:post, :implemented => flag) }
    expect(Post.implemented).to eq(posts[1..1])
  end

  it 'should be scopable by published posts' do
    Post.delete_all
    posts = [false, true].map{|flag| FactoryGirl.create(:post, :published => flag) }
    expect(Post.published).to eq(posts[1..1])
  end

  it "should reflect :id & :title when converted to param" do
    post.title = 'Super Mighty Proc'
    expect(post.to_param).to eq(post.instance_exec{"#{id}-#{title.parameterize}"})
  end

  it "should notify admin after create" do
    expect(Delayed::Job).to receive(:enqueue)
    FactoryGirl.create(:post)
  end

  context "publish!" do
    before :each do
      @post = FactoryGirl.create(:post, :published => false)
    end

    it "should mark published as true" do
      @post.publish!
      expect(@post).to be_published
    end

    it "should tweet after publish!" do
      expect(Delayed::Job).to receive(:enqueue)
      @post.publish!
    end
  end

  context "prev" do
    before :each do
      @post1 = FactoryGirl.create(:post, :vote_points => 20)
      @post2 = FactoryGirl.create(:post, :vote_points => 10, :implemented => true)
    end

    it "should order by id" do
      expect(@post1.prev("id")).to be_nil
      expect(@post2.prev("id")).to eq(@post1)
    end

    it "should order by vote_points" do
      expect(@post1.prev("vote_points")).to eq(@post2)
      expect(@post2.prev("vote_points")).to be_nil
    end

    it "should order by implemented" do
      @post3 = FactoryGirl.create(:post, :implemented => true)
      expect(@post2.prev("implemented")).to be_nil
      expect(@post3.prev("implemented")).to eq(@post2)
    end
  end

  context "next" do
    before :each do
      @post1 = FactoryGirl.create(:post, :vote_points => 20, :implemented => true)
      @post2 = FactoryGirl.create(:post, :vote_points => 10, :implemented => true)
    end

    it "should order by id" do
      expect(@post1.next("id")).to eq(@post2)
      expect(@post2.next("id")).to be_nil
    end

    it "should order by vote_points" do
      expect(@post1.next("vote_points")).to be_nil
      expect(@post2.next("vote_points")).to eq(@post1)
    end

    it "should order by implemented" do
      @post3 = FactoryGirl.create(:post)
      expect(@post1.next("implemented")).to eq(@post2)
      expect(@post2.next("implemented")).to be_nil
    end
  end
end
