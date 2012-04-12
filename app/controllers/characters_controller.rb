class CharactersController < ApplicationController
  before_filter :authenticate, :only => [:new, :edit, :update]

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
    flash[:debug] = "Edit goes here!"
  end

end
