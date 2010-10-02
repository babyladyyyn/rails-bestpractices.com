require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe User do

  include RailsBestPractices::Spec::Support
  should_be_gravastic
  should_act_as_authentic # This affects the validity of a user

  should_have_many :posts, :dependent => :destroy
  should_have_many :comments, :dependent => :destroy
  should_have_many :votes, :dependent => :destroy
  should_have_many :implementations, :dependent => :destroy
  should_have_many :questions, :dependent => :destroy
  should_have_many :answers, :dependent => :destroy
  should_have_many :notifications, :dependent => :destroy
  should_have_one :access_token

  describe 'when email validation is required' do
    before { Factory(:user) }
    should_validate_length_of :email, :within => 6..100
    should_allow_values_for :email, 'flyerhzm@gmail.com'
    should_not_allow_values_for :email, 'flyerhzm'
    should_validate_uniqueness_of :email
  end

  describe 'when email validation is not required' do
    before { Factory(:user) }
    subject { @user = Factory(:user, :access_token => AccessToken.new) }
    should_not_validate_length_of :email, :within => 6..100
    should_allow_values_for :email, 'flyerhzm@gmail.com', 'flyerhzm'
    should_not_validate_uniqueness_of :email
  end

  describe 'when password validation is required' do
    should_validate_length_of :password, :minimum => 4
    should_validate_confirmation_of :password
  end

  describe 'when password validation is not required' do
    subject { @user = Factory(:user, :access_token => AccessToken.new) }
    should_not_validate_length_of :password, :minimum => 4
    should_not_validate_confirmation_of :password
  end

  describe 'updating profile' do

    let(:login) { 'flyerhzm' }
    let(:profile_name) { '~flyerhzm~' }
    let(:user) { Factory(:user, :login => login) }
    before do
      user.stub!(:profile => {:name => profile_name})
    end

    it 'should not be allowed if :access_token is absent' do
      user.update_profile.should be_nil
      user.login.should == login
    end

    it 'should update :login if :access_token is present' do
      user.access_token = AccessToken.new
      user.update_profile.should_not be_nil
      user.login.should == profile_name
    end

  end

  it "should reflect :id & :login when converted to param" do
    user = Factory(:user, :login => 'flyerhzm')
    user.to_param.should == "#{user.id}-flyerhzm"
  end

end
