# == Schema Information
#
# Table name: sponsor_tracks
#
#  id         :integer(4)      not null, primary key
#  sponsor_id :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class SponsorTrack < ActiveRecord::Base

  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :sponsor
end
