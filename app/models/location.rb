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
# Indexes
#
#  fk__locations_universe_id                   (universe_id)
#  index_locations_on_universe_id_and_address  (universe_id,address) UNIQUE
#

class Location < ActiveRecord::Base
  belongs_to :universe, inverse_of: :locations
  validates_presence_of :address, :name, :universe
end
