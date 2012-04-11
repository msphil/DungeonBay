# == Schema Information
#
# Table name: campaigns
#
#  id          :integer         not null, primary key
#  owner_id    :integer
#  name        :string(255)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'

describe Campaign do
  before(:each) do
    @attr = {
      :owner_id => 1,
      :name => "name",
      :description => "description"
    }
  end

  it "should create a new instance given valid attributes" do
    Campaign.create!(@attr)
  end

end

