class AddImagesToCampaignsAndCharacters < ActiveRecord::Migration
  def self.up
    add_column :campaigns, :img_url, :string
    add_column :characters, :img_url, :string
  end

  def self.down
    remove_column :characters, :img_url
    remove_column :campaigns, :img_url
  end
end
