require 'spec_helper'

describe Item do

  before(:each) do
    @user = Factory(:user)
    @attr = {
      :description => "a description",
      :campaign_id => 1,
      :image_url => "http://localhost/images/logo.png"
    }
  end

  it "should create a new instance given valid attributes" do
    @user.items.create!(@attr)
  end

  describe "validations" do

    it "should require a user id" do
      Item.new(@attr).should_not be_valid
    end

    it "should require nonblank description" do
      @user.items.build(:description => "  ").should_not be_valid
    end

    it "should reject long description" do
      @user.items.build(:description => "a" * 1500).should_not be_valid
    end

  end

  describe "user associations" do

    before(:each) do
      @item = @user.items.create(@attr)
    end

    it "should have a user attribute" do
      @item.should respond_to(:user)
    end

    it "should have the right associated user" do
      @item.owner_id.should == @user.id
      @item.user.should == @user
    end

  end

end
