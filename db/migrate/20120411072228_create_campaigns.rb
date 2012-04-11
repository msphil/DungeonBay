class CreateCampaigns < ActiveRecord::Migration
  def self.up
    create_table :campaigns do |t|
      t.integer :owner_id
      t.string :name
      t.string :description

      t.timestamps
    end
    add_index :campaigns, :owner_id
    add_index :campaigns, :name
  end

  def self.down
    drop_table :campaigns
  end
end
