# == Schema Information
#
# Table name: auctions
#
#  id           :integer         not null, primary key
#  creator_id   :integer
#  item_id      :integer
#  description  :string(255)
#  open_bid     :integer
#  buyout_price :integer
#  expires      :datetime
#  current_bid  :integer
#  bidder_id    :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Auction < ActiveRecord::Base
  attr_accessible :description, :open_bid, :buyout_price, :current_bid

  validates :creator_id,  :presence => true
  #validates :item_id,  :presence => true
  validates :description,  :presence => true, :length => { :within => 1..250 }

  belongs_to :user, :foreign_key => "creator_id"

  def self.search(query)
    if !query.to_s.strip.empty?
      tokens = query.split.collect {|c| "%#{c.downcase}%"}
      find_by_sql(["select s.* from auctions s where #{ (["(lower(s.description) like ?)"] * tokens.size).join(" and ") } order by s.created_at desc", *(tokens * 1).sort])
    else
      []
    end
  end
end
