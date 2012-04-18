module AuctionsHelper

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
