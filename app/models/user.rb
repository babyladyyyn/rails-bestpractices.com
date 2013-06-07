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
#  admin                     :boolean(1)      default(FALSE), not null
#  reset_password_sent_at    :datetime
#

require 'devise/orm/active_record'
class User < ActiveRecord::Base

  include ActiveModel::ForbiddenAttributesProtection
  include Cacheable
  include Gravtastic
  gravtastic

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :encryptable, :encryptor => :authlogic_sha512

  validates :login, :presence => true, :uniqueness => true

  has_many :posts, :dependent => :destroy
  has_many :votes, :dependent => :destroy
  has_many :questions, :dependent => :destroy
  has_many :answers, :dependent => :destroy
  has_many :notifications, :dependent => :destroy
  has_many :notification_settings, :dependent => :destroy
  has_many :authentications, :dependent => :destroy
  has_many :jobs, :dependent => :destroy

  accepts_nested_attributes_for :notification_settings

  model_cache do
    with_key
    with_attribute :email
  end

  def name
    self.login
  end

  def to_param
    "#{id}-#{login.parameterize}"
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end

  def apply_omniauth(omniauth)
    self.login = omniauth['info']['nickname'] if login.blank?
    authentications.build(
      :provider => omniauth['provider'],
      :uid => omniauth['uid'],
      :token => omniauth['credentials']['token'],
      :secret => omniauth['credentials']['secret']
    )
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
end
