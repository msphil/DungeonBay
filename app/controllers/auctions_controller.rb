class AuctionsController < ApplicationController
  before_filter :authenticate, :only => [:new, :create, :destroy]
  before_filter :is_my_item

  def create
    @auction = current_user.auctions.build(params[:auction])
    @auction.creator_id = current_user.id
    @auction.item_id = current_item.id
    if @auction.save
      flash[:success] = "Auction created!"
      redirect_to root_path
    else
      render 'pages/home'
    end
  end

  def index
    @auctions = Auction.paginate(:page => params[:page])
    @title = "All auctions"
  end

  def destroy
  end

  def new
    i = current_item
    @title = "Create auction"
    @auction = Auction.new
  end

  def is_my_item
    if signed_in? and character_selected? and item_selected?
      if current_character.owner_id == current_user.id and current_item.owner_id == current_character.id
        return true
      end
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

end
