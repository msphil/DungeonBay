class CreateAuctions < ActiveRecord::Migration
  def self.up
    create_table :auctions do |t|
      t.integer :creator_id
      t.integer :item_id
      t.string :description
      t.integer :open_bid
      t.integer :buyout_price
      t.datetime :expires
      t.integer :current_bid
      t.integer :bidder_id

      t.timestamps
    end
    add_index :auctions, [:creator_id, :item_id]
    add_index :auctions, :expires
    add_index :auctions, [:current_bid, :bidder_id]
  end

  def self.down
    drop_table :auctions
  end
end
