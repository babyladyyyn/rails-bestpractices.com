class JobPartner < ActiveRecord::Base
  validates_presence_of :name, :token
end
