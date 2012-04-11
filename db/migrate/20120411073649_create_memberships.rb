class CreateMemberships < ActiveRecord::Migration
  def self.up
    create_table :memberships do |t|
      t.integer :character_id
      t.integer :campaign_id

      t.timestamps
    end
    add_column :memberships, :gm, :boolean, :default => false
    add_index :memberships, [:character_id, :campaign_id]
    add_index :memberships, :character_id, :campaign_id
    add_index :memberships, :campaign_id
  end

  def self.down
    drop_table :memberships
  end
end
