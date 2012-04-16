class AuctionsController < ApplicationController
  before_filter :authenticate, :only => [:create, :destroy]

  def create
    @auction = current_user.auctions.build(params[:auction])
    if @auction.save
      flash[:success] = "Auction created!"
      redirect_to root_path
    else
      render 'pages/home'
    end
  end

  def index
  end

  def destroy
  end

end
