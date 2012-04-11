# == Schema Information
#
# Table name: characters
#
#  id          :integer         not null, primary key
#  owner_id    :integer
#  campaign_id :integer
#  name        :string(255)
#  description :string(255)
#  gold        :integer
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'

describe Character do

  before(:each) do
    @user = Factory(:user)
    @campaign = Factory(:campaign, :user => @user)
    @user_attr = {
      :name => "Example User",
      :email => "user@example.com",
      :password => "foobar",
      :password_confirmation => "foobar"
    }
    @campaign_attr = {
      :owner_id => 1,
      :name => "name",
      :description => "description"
    }
    @char_attr = {
      :owner_id => @user.id,
      :campaign_id => @campaign.id,
      :name => "a name",
      :description => "a description",
      :gold => 9999
    }
    @character = Factory(:character, :user => @user, :campaign => @campaign)
  end

  it "should create a new instance given valid attributes" do
    @character.should be_valid
  end

  describe "item associations" do

    before(:each) do
      @character = Factory(:character, :user => @user, :campaign => @campaign)
      @it1 = Factory(:item, :character => @character)
      @it2 = Factory(:item, :character => @character)
    end

    it "should have a items attribute" do
      @character.should respond_to(:items)
    end

    it "should destroy associated items" do
      @character.destroy
      [@it1, @it2].each do |item|
        Item.find_by_id(item.id).should be_nil
      end
    end

  end

end

