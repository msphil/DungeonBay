require 'spec_helper'

describe ItemsController do
  render_views

  describe "access control" do

    it "should deny access to 'create'" do
      post :create
      response.should redirect_to(signin_path)
    end

    it "should deny access to 'destroy'" do
      delete :destroy, :id => 1
      response.should redirect_to(signin_path)
    end

  end

  describe "POST 'create'" do

    before(:each) do
      @user = test_sign_in(Factory(:user))
    end

    describe "failure" do

      before(:each) do
        @attr = { :description => "" }
      end

      # converted to pending since interface needs revisiting
      it "should not create a item"
#      it "should not create a item" do
#        lambda do
#          post :create, :item => @attr
#        end.should_not change(Item, :count)
#      end

      it "should render the home page" 
#      it "should render the home page" do
#        post :create, :item => @attr
#        response.should render_template('pages/home')
#      end
    end

    describe "success" do

      before(:each) do
        @attr = { :description => "Lorem ipsum" }
      end

      it "should create a item"
#      it "should create a item" do
#        lambda do
#          post :create, :item => @attr
#        end.should change(Item, :count).by(1)
#      end

      it "should redirect to the home page"
#      it "should redirect to the home page" do
#        post :create, :item => @attr
#        response.should redirect_to(root_path)
#      end

      it "should have a flash message"
#      it "should have a flash message" do
#        post :create, :item => @attr
#        flash[:success].should =~ /item created/i
#      end
     
    end

  end

end
