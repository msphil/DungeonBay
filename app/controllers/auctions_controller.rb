class AuctionsController < ApplicationController
  before_filter :authenticate, :only => [:new, :create, :destroy, :bid, :update_bid, :finish_auction]
  before_filter :is_my_item, :only => [:new, :create, :destroy]

  def create
    a = Auction.find_by_item_id(current_item.id)
    if a
      flash[:error] = "That item already has an auction!"
      redirect_to root_path
    else
      @auction = current_user.auctions.build(params[:auction])
      @auction.creator_id = current_character.id
      @auction.item_id = current_item.id
      if @auction.save
        flash[:success] = "Auction created!"
        redirect_to root_path
      else
        flash[:error] = "Auction could not be created (probably missing a description)!"
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
      flash[:error] = "Invalid auction id"
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
    if bid > 0
      if bid <= @auction.buyout_price
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
      else
        flash[:error] = "Bids cannot exceed the buyout price!"
      end
    else
      flash[:error] = "Negative bids are not permitted!"
    end
    redirect_to @auction
  end

  def is_my_item
    if signed_in? and character_selected? and item_selected?
      if current_character.owner_id == current_user.id and current_item.owner_id == current_character.id
        return true
      end
    end
    redirect_to root_path
  end

  def buy_it_now
    @title = "Buy it now!"
    @auction = Auction.find(params[:id])
    if @auction
      @auction.current_bid = @auction.buyout_price
      @auction.bidder_id = current_character.id
      complete_auction @auction
      redirect_to current_character
    else
      flash[:error] = "No such auction!"
      redirect_to root_path
    end
  end

  def finish_auction
    @title = "Completed auction"
    @auction = Auction.find(params[:id])
    if @auction
      item = Item.find(@auction.item_id)
      complete_auction @auction
      flash[:success] = "Your auction has completed!"
      if character_selected?
        redirect_to current_character
      else
        redirect_to root_path
      end
    else
      flash[:error] = "Unable to locate auction"
      redirect_to root_path
    end
  end

  def complete_auction(auction)
    item = Item.find(auction.item_id)
    if auction.current_bid and auction.bidder_id
      buyer = Character.find(auction.bidder_id)
      seller = Character.find(auction.creator_id)
      if buyer and seller and item
        buyer.gold = buyer.gold.to_i - auction.current_bid.to_i
        seller.gold = seller.gold.to_i + auction.current_bid.to_i
        item.owner_id = buyer.id
        buyer.save
        seller.save
        item.save
      end
      auction.delete
    else
      # expire the auction altogether
      auction.delete
    end
  end

  def expire_all_auctions
    Auction.all do |a|
      complete_auction a
    end
  end

end
