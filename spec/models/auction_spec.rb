# == Schema Information
#
# Table name: auctions
#
#  id           :integer         not null, primary key
#  creator_id   :integer
#  item_id      :integer
#  description  :string(255)
#  open_bid     :integer
#  buyout_price :integer
#  expires      :datetime
#  current_bid  :integer
#  bidder_id    :integer
#  created_at   :datetime
#  updated_at   :datetime
#

require 'spec_helper'

describe Auction do

  before(:each) do
    @user = Factory(:user)
    @attr = {
      :item_id => 1,
      :description => "description",
      :open_bid => 100,
      :buyout_price => 1000,
      :expires => 1.minute.from_now,
      :bidder_id => 0,
      :current_bid => 0,
      :created_at => Time.now
    }
  end

  it "should create a new instance given valid attributes" do
    @user.auctions.create!(@attr)
  end

  describe "user associations" do

    before(:each) do
      @auction = @user.auctions.create(@attr)
    end

    it "should have a user attribute" do
      @auction.should respond_to(:user)
    end

    it "should have the right associated user" do
      @auction.user.should == @user
    end

  end

end
