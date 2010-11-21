class NotificationSetting < ActiveRecord::Base
  attr_accessor :description

  belongs_to :user

  ITEMS = ActiveSupport::OrderedHash[
    :global_email, 'Receive email notification (global setting)',
    :comment_post, 'Comment on my Rails Best Practice',
    :comment_comment, 'Comment on Rails Best Practice after me',
    :answer_question, 'Answer on my Question',
    :answer_answer, 'Answer on Question after me'
  ]

  def description
    ITEMS[self.name.to_sym]
  end
end
