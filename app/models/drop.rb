# == Schema Information
#
# Table name: drops
#
#  id             :integer(4)      not null, primary key
#  title          :string(255)
#  body           :text
#  user_id        :integer(4)
#  formatted_html :text
#  description    :text
#  kind           :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  tag_list       :string(255)
#

class Drop < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :title, :kind, :tag_list, :body

  def belongs_to?(user)
    user && self.user == user
  end
end

