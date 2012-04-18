class ItemsController < ApplicationController
  before_filter :authenticate
  before_filter :is_gm_character

  def new
    @item = Item.new
    @title = "Create new item"
    #@item.creator_id = current_user.id
    #@item.campaign_id = current_campaign.id
    #@item.owner_id = current_character.id
  end

  def create
    @item = current_campaign.items.build(params[:item])
    @item.creator_id = current_user.id
    @item.campaign_id = current_campaign.id
    @item.owner_id = current_character.id
    if @item.save
      flash[:success] = "Item created!"
      redirect_to current_user
    else
      flash[:error] = "Item was not created due to an error."
      redirect_to root_path
    end
  end

  def destroy
  end

  def is_gm_character
    if signed_in? and character_selected? and campaign_selected?
      if current_campaign.owner_id == current_user.id and current_character.campaign_id == current_campaign.id and current_character.owner_id == current_user.id
        return true
      end
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

end
