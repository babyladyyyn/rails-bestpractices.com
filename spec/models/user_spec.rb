require 'spec_helper'

describe User do

  include RailsBestPractices::Spec::Support
  should_be_gravastic

  should_have_many :posts, :dependent => :destroy
  should_have_many :comments, :dependent => :destroy
  should_have_many :votes, :dependent => :destroy
  should_have_many :questions, :dependent => :destroy
  should_have_many :answers, :dependent => :destroy
  should_have_many :notifications, :dependent => :destroy
  should_have_many :notification_settings, :dependent => :destroy

  context "validations" do
    before { Factory(:user) }
    it { should validate_presence_of :login }
    it { should validate_uniqueness_of :login }
  end

  it "should reflect :id & :login when converted to param" do
    user = Factory(:user, :login => 'flyerhzm')
    user.to_param.should == "#{user.id}-flyerhzm"
  end

  describe "notification settings" do
    let(:user) { Factory(:user) }

    it "should return true if there is no such notification setting" do
      user.should be_comment_post
    end

    it "should return true if the notification setting is true" do
      Factory(:notification_setting, :name => 'global_email', :value => '1', :user => user)
      Factory(:notification_setting, :name => 'comment_post', :value => '1', :user => user)
      user.should be_comment_post
    end

    it "should return false if the comment post setting is false" do
      Factory(:notification_setting, :name => 'global_email', :value => '1', :user => user)
      Factory(:notification_setting, :name => 'comment_post', :value => '0', :user => user)
      user.should_not be_comment_post
    end

    it "should return false if the global email setting is false" do
      Factory(:notification_setting, :name => 'global_email', :value => '0', :user => user)
      Factory(:notification_setting, :name => 'comment_post', :value => '1', :user => user)
      user.should_not be_comment_post
    end
  end

end


