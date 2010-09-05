class User < ActiveRecord::Base
  include ConnectProfile
  acts_as_authentic do |config|
    config.validate_email_field = false
    config.validate_password_field = false
  end

  validates_length_of :email, :within => 6..100, :if => :validate_email?
  validates_format_of :email, :with => Authlogic::Regex.email, :if => :validate_email?
  validates_uniqueness_of :email, :if => :validate_email?
  validates_length_of :password, :minimum => 4, :if => :validate_password?
  validates_confirmation_of :password, :if => :validate_password?
  is_gravtastic!
  
  has_many :posts, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :votes, :dependent => :destroy
  has_many :implementations, :dependent => :destroy
  has_many :questions, :dependent => :destroy
  has_many :answers, :dependent => :destroy
  has_many :notifications, :dependent => :destroy
  has_many :drops, :dependent => :destroy
  has_one :access_token

  def update_profile
    if self.access_token
      self.update_attribute(:login, self.profile[:name])
    end
  end

  def name
    self.login
  end

  def to_param
    "#{id}-#{login.parameterize}"
  end

  private
    def validate_email?
      self.access_token.nil?
    end

    def validate_password?
      self.access_token.nil? and (new_record? or password_changed?)
    end
end
