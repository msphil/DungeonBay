class ItemsController < ApplicationController
  before_filter :authenticate

  def create
    @item  = current_character.items.build(params[:item])
    if @item.save
      flash[:success] = "Item created!"
      redirect_to root_path
    else
      render 'pages/home'
    end
  end

  def destroy
  end
end
