class AuctionsController < ApplicationController
  before_filter :authenticate, :only => [:new, :create, :destroy]
  before_filter :is_my_item, :only => [:new, :create, :destroy]

  def create
    a = Auction.find_by_item_id(current_item.id)
    if a
      flash[:error] = "That item already has an auction!"
      redirect_to root_path
    else
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
  end

  def index
    @auctions = Auction.paginate(:page => params[:page])
    @title = "All auctions"
  end

  def show
    @auction = Auction.find(params[:id])
    @title = "Auction"
  end

  def destroy
  end

  def new
    i = current_item
    @title = "Create auction"
    @auction = Auction.new
  end

  def bid
    @title = "Bid!"
    @auction = Auction.find(params[:id])
    if @auction
      @item = Item.find(@auction.item_id)
    else
      redirect_to root_path
    end
  end

  def search
    @title = "Auction search"
  end

  def search_results
    @auctions = Auction.search(params[:search_terms]).paginate(:page => params[:page])
  end

  def update_bid
    @auction = Auction.find(params[:id])
    @item = Item.find(@auction.item_id)
    bid = params[:bid].to_i
    if signed_in?
      if character_selected?
        if current_character.campaign_id == @item.campaign_id
          if current_character.gold >= bid
            if !@auction.current_bid or bid > @auction.current_bid
              @auction.current_bid = bid
              @auction.bidder_id = current_character.id
              @auction.save
              # Gold does not transfer here, it transfers when the auction is complete
            else
              flash[:error] = "Your bid must be greater than the current high bid!"
            end
          else
            flash[:error] = "Your current character does not have enough gold for that bid!"
          end
        else
          flash[:error] = "Your current character must be in the campaign with the item!"
        end
      else
        flash[:error] = "You must have a character selected to bid!"
      end
    else
      flash[:error] = "You must be signed in to bid!"
    end
    redirect_to @auction
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
