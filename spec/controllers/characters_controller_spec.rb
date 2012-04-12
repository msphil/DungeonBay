require 'spec_helper'

describe CharactersController do
  render_views

  describe "GET 'new'" do

    describe "for signed-out user" do

      it "should redirect to signin" do
        get :new
        response.should redirect_to(signin_path)
      end

    end

    describe "for signed-in user" do

      before(:each) do
        @user = test_sign_in(Factory(:user))
      end

      it "should be successful" do
        get :new
        response.should be_success
      end

      it "should have the correct title" do
        get :new
        response.should have_selector("title", :content => "Create character")
      end

      it "should have a name field" do
        get :new
        response.should have_selector("input[name='character[name]'][type='text']")
      end

      it "should have a description field" do
        get :new
        response.should have_selector("input[name='character[description]'][type='text']")
      end

    end

  end

end
