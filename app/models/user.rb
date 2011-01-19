# == Schema Information
#
# Table name: users
#
#  id                        :integer(4)      not null, primary key
#  login                     :string(255)
#  email                     :string(255)
#  crypted_password          :string(255)
#  password_salt             :string(255)
#  persistence_token         :string(255)
#  single_access_token       :string(255)
#  perishable_token          :string(255)
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
#

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
  has_many :questions, :dependent => :destroy
  has_many :answers, :dependent => :destroy
  has_many :notifications, :dependent => :destroy
  has_many :drops, :dependent => :destroy
  has_one :access_token
  has_many :notification_settings, :dependent => :destroy

  accepts_nested_attributes_for :notification_settings

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

  NotificationSetting::ITEMS.keys.each do |item_name|
    class_eval <<-EOF
      def #{item_name}?
        self.notification_settings.blank? ||
        (self.notification_settings.where(:name => 'global_email').first.value &&
        self.notification_settings.where(:name => '#{item_name}').first.value)
      end
    EOF
  end

  private
    def validate_email?
      self.access_token.nil?
    end

    def validate_password?
      self.access_token.nil? and (new_record? or password_changed?)
    end
end

