# == Schema Information
#
# Table name: authentications
#
#  id         :integer(4)      not null, primary key
#  provider   :string(255)
#  uid        :string(255)
#  user_id    :integer(4)
#  token      :string(255)
#  secret     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Authentication < ActiveRecord::Base
  belongs_to :user
end
