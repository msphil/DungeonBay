module ItemsHelper

  def get_auction(item)
    return Auction.find_by_item_id(item.id)
  end

end
