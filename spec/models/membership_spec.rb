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

require 'spec_helper'

describe Membership do
  before(:each) do
    @attr = {
      :character_id => 1,
      :campaign_id => 1,
      :gm => false
    }
  end

  it "should create a new instance given valid attributes" do
    Membership.create!(@attr)
  end

end

