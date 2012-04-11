# == Schema Information
#
# Table name: memberships
#
#  id           :integer         not null, primary key
#  character_id :integer
#  campaign_id  :integer
#  gm           :boolean
#  created_at   :datetime
#  updated_at   :datetime
#

class Membership < ActiveRecord::Base
  has_one :character
  has_one :campaign
end

