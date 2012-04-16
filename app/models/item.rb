class Item < ActiveRecord::Base
  attr_accessible :name, :description, :image_url

  validates :name, :presence => true, :length => { :within => 1..80 }
  validates :description, :presence => true, :length => { :maximum => 1023 }
  validates :owner_id, :presence => true

  default_scope :order => 'items.created_at DESC'

  belongs_to :character, :foreign_key => "owner_id"
end


# == Schema Information
#
# Table name: items
#
#  id          :integer         not null, primary key
#  creator_id  :integer
#  owner_id    :integer
#  campaign_id :integer
#  image_url   :string(255)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  name        :string(255)
#

