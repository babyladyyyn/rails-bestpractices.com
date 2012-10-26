# == Schema Information
#
# Table name: notification_settings
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  value      :boolean(1)      default(TRUE)
#  user_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class NotificationSetting < ActiveRecord::Base

  include ActiveModel::ForbiddenAttributesProtection

  attr_accessor :description

  belongs_to :user

  ITEMS = ActiveSupport::OrderedHash[
    :global_email            , 'Receive email notification (global setting)' ,
    :answer_question         , 'Answer on my Question'                       ,
    :after_question_answer   , 'Answer on Question after me'                 ,
  ]

  def description
    ITEMS[self.name.to_sym]
  end
end

