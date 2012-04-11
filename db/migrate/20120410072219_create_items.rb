class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.integer :creator_id
      t.integer :owner_id
      t.integer :campaign_id
      t.string :image_url
      t.string :description

      t.timestamps
    end
    add_index :items, [:owner_id, :campaign_id]
    add_index :items, :creator_id
    add_index :items, :description
  end

  def self.down
    drop_table :items
  end
end
