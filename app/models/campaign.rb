# == Schema Information
#
# Table name: campaigns
#
#  id          :integer         not null, primary key
#  owner_id    :integer
#  name        :string(255)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Campaign < ActiveRecord::Base
  has_many :items, :dependent => :destroy
  has_many :characters, :dependent => :destroy

  belongs_to :user, :foreign_key => "owner_id"
end
