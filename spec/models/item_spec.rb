# == Schema Information
#
# Table name: items
#
#  id          :integer         not null, primary key
#  creator_id  :integer
#  owner_id    :integer
#  campaign_id :integer
#  image_url   :string(255)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'

describe Item do

  before(:each) do
    @user = Factory(:user)
    @campaign = Factory(:campaign, :user => @user)
    @character = Factory(:character, :user => @user, :campaign => @campaign)
    @item_attr = {
      :name => "a name",
      :description => "a description",
      :campaign_id => 1,
      :image_url => "http://localhost/images/logo.png"
    }
  end

  it "should create a new instance given valid attributes" do
    @character.items.create!(@item_attr)
  end

  describe "validations" do

    it "should require a user id" do
      Item.new(@item_attr).should_not be_valid
    end

    it "should require nonblank description" do
      @character.items.build(:description => "  ").should_not be_valid
    end

    it "should reject long description" do
      @character.items.build(:description => "a" * 1500).should_not be_valid
    end

  end

  describe "character associations" do

    before(:each) do
      @item = @character.items.create(@item_attr)
    end

    it "should have a character attribute" do
      @item.should respond_to(:character)
    end

    it "should have the right associated character" do
      @item.owner_id.should == @character.id
      @item.character.should == @character
    end

  end

end

