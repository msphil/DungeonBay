module AuctionsHelper

  def get_current_bid(auction)
    if auction.current_bid
      return auction.current_bid.to_s + " gold"
    else
      if auction.open_bid
        return auction.open_bid.to_s + " gold"
      else
        return "[No bids yet]"
      end
    end
  end

  def get_current_bid_value(auction)
    if auction.current_bid
      return auction.current_bid
    else
      if auction.open_bid
        return auction.open_bid
      else
        return 0
      end
    end
  end

  def get_bidder_name(auction)
    if auction.bidder_id
      c = Character.find(auction.bidder_id)
      return c.name
    else
      return "[No bidder]"
    end
  end

  def get_buyout_price(auction)
    if auction.buyout_price
      return auction.buyout_price.to_s + " gold"
    else
      return "[No buyout price]"
    end
  end

end
