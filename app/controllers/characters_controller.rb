class CharactersController < ApplicationController
  before_filter :authenticate, :only => [:new, :edit, :update]
  before_filter :correct_user, :only => [:edit, :update]

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

  def correct_user
    @character = Character.find(params[:id])
    @user = User.find(@character.owner_id)
    redirect_to(root_path) unless current_user?(@user)
  end

end
