# == Schema Information
#
# Table name: users
#
#  id                        :integer(4)      not null, primary key
#  login                     :string(255)
#  email                     :string(255)
#  encrypted_password        :string(255)
#  password_salt             :string(255)
#  created_at                :datetime
#  updated_at                :datetime
#  url                       :string(255)
#  posts_count               :integer(4)      default(0), not null
#  comments_count            :integer(4)      default(0), not null
#  votes_count               :integer(4)      default(0), not null
#  active_token_id           :integer(4)
#  questions_count           :integer(4)      default(0), not null
#  answers_count             :integer(4)      default(0), not null
#  unread_notification_count :integer(4)      default(0), not null
#  reset_password_token      :string(255)
#  remember_token            :string(255)
#  remember_created_at       :datetime
#  sign_in_count             :integer(4)
#  current_sign_in_at        :datetime
#  last_sign_in_at           :datetime
#  current_sign_in_ip        :string(255)
#  last_sign_in_ip           :string(255)
#  authentication_token      :string(255)
#

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


