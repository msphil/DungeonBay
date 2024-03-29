class CharactersController < ApplicationController
  before_filter :authenticate, :only => [:new, :edit, :update, :add_gold]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :is_gm, :only => [:add_gold, :update_gold]

  def new
    u = current_user
    @title = "Create character"
    @character = u.characters.new
  end

  def create
    @character = Character.new(params[:character])
    @character.owner_id = current_user.id
    @character.gold = 0
    if @character.save
      flash[:success] = "Character created!"
      redirect_to current_user
    else
      render 'new'
    end
  end

  def edit
    @title = "Edit character"
  end

  def show
    @character = Character.find(params[:id])
    @title = @character.name
  end

  def select
    @character = Character.find(params[:id])
    if @character.owner_id == current_user.id
      @title = @character.name + " selected"
      flash[:success] = "Signed in as " + @character.name + "!"
      select_character @character
      redirect_to current_user
    else
      flash[:error] = "You cannot sign in as a character you do not own!"
      redirect_to root_path
    end
  end

  def update
    @character = Character.find(params[:id])
    if @character.update_attributes(params[:character])
      flash[:success] = "Profile updated."
      redirect_to @character
    else
      @title = "Edit character"
      render 'edit'
    end
  end

  def index
    @characters = Character.paginate(:page => params[:page])
    @title = "All characters"
  end

  def index_campaignless
    @characters = Character.where(:campaign_id => nil)#.paginate
    @title = "Characters lacking a campaign"
  end

  def correct_user
    @character = Character.find(params[:id])
    @user = User.find(@character.owner_id)
    redirect_to(root_path) unless current_user?(@user)
  end

  def is_gm
    @character = Character.find(params[:id])
    if @character.campaign_id != current_campaign.id and current_campaign.owner_id != current_user.id
      redirect_to root_path
    end
  end

  def add_gold
    @character = Character.find(params[:id])
    @title = "Add gold to " + @character.name
  end

  def update_gold
    @character = Character.find(params[:id])
    new_gold = params[:gold].to_i
    @character.gold += new_gold
    @character.save
    redirect_to current_campaign
  end

end
