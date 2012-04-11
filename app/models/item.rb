class Item < ActiveRecord::Base
  attr_accessible :description, :image_url

  validates :description, :presence => true, :length => { :maximum => 1023 }
  validates :owner_id, :presence => true

  default_scope :order => 'items.created_at DESC'

  belongs_to :user, :foreign_key => "owner_id"
end
