class CreateCharacters < ActiveRecord::Migration
  def self.up
    create_table :characters do |t|
      t.integer :owner_id
      t.integer :campaign_id
      t.string :name
      t.string :description
      t.integer :gold

      t.timestamps
    end
    add_index :characters, [:owner_id, :campaign_id]
    add_index :characters, :owner_id
    add_index :characters, :campaign_id
  end

  def self.down
    drop_table :characters
  end
end
