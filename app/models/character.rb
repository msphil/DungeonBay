# == Schema Information
#
# Table name: characters
#
#  id          :integer         not null, primary key
#  owner_id    :integer
#  campaign_id :integer
#  name        :string(255)
#  description :string(255)
#  gold        :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Character < ActiveRecord::Base
  attr_accessible :name, :description#, :image_url

  validates :name, :presence => true, :length => { :within => 1..50 }
  validates :description, :presence => true, :length => { :maximum => 1023 }

  belongs_to :user, :foreign_key => "owner_id"
  has_one :campaign
  has_many :items, :dependent => :destroy, :foreign_key => "owner_id"

  validates :owner_id, :presence => true

end
