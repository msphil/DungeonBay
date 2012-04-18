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

  def add_character
    @campaign = Campaign.find(params[:campaign_id])
    @character = Character.find(params[:character_id])
    if @campaign
      if @character
        if @character.campaign_id == nil
          @character.campaign_id = @campaign.id
          @character.save
          redirect_to @campaign
        else
          flash[:error] = "Character is already in a campaign!"
          redirect_to root_path
        end
      else
        flash[:error] = "No such character!"
        redirect_to root_path
      end
    else
      flash[:error] = "Invalid campaign!"
      redirect_to root_path
    end
  end

  def add_gold_to_character
    @character = Character.find(params[:character_id])
    if @character
      if campaign_selected?
        if @character.campaign_id == current_campaign.id
          @character.gold += params[:gold]
          @character.save
        end
      end
    end
    redirect_to campaign_path
  end

  def select
    @campaign = Campaign.find(params[:id])
    if @campaign.owner_id == current_user.id
      @title = @campaign.name + " selected"
      flash[:success] = "Selected " + @campaign.name + "!"
      select_campaign @campaign
      redirect_to current_user
    else
      flash[:error] = "You cannot sign in to a campaign you do not own!"
      redirect_to root_path
    end
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
