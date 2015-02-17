# == Schema Information
#
# Table name: locations
#
#  id          :integer          not null, primary key
#  address     :string           not null
#  name        :string           not null
#  universe_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Location < ActiveRecord::Base
  belongs_to :universe, inverse_of: :locations
  validates_presence_of :address, :name, :universe
end
