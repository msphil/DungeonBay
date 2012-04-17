class CampaignsController < ApplicationController
  before_filter :authenticate, :only => [:new, :edit, :update]
  before_filter :correct_user, :only => [:edit, :update]

  def new
    u = current_user
    @title = "Create campaign"
    @campaign = u.campaigns.new
  end

  def create
    @campaign = Campaign.new(params[:campaign])
    @campaign.owner_id = current_user.id
    if @campaign.save
      flash[:success] = "Campaign created!"
      redirect_to current_user
    else
      render 'new'
    end
  end

  def edit
    @title = "Edit campaign"
  end

  def show
    @campaign = Campaign.find(params[:id])
    @title = @campaign.name
  end

  def update
    @campaign = Campaign.find(params[:id])
    if @campaign.update_attributes(params[:campaign])
      flash[:success] = "Profile updated."
      redirect_to @campaign
    else
      @title = "Edit campaign"
      render 'edit'
    end
  end

  def correct_user
    @campaign = Campaign.find(params[:id])
    @user = User.find(@campaign.owner_id)
    redirect_to(root_path) unless current_user?(@user)
  end

end
