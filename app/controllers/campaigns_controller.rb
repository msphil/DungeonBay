class CampaignsController < ApplicationController
  before_filter :authenticate, :only => [:new, :edit, :update]

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
    flash[:debug] = "Edit goes here!"
  end

end
