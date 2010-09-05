class Drop < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :title, :kind, :tag_list, :body

  def belongs_to?(user)
    user && self.user == user
  end
end
