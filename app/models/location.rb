# == Schema Information
#
# Table name: locations
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  group       :string
#  universe_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  hidden      :boolean          default(FALSE), not null
#
# Indexes
#
#  index_locations_on_universe_id_and_name  (universe_id) UNIQUE
#

class Location < ActiveRecord::Base
  belongs_to :universe, inverse_of: :locations
  validates_presence_of :name, :universe

  default_scope{order(:group, :name)}
  scope :sorted_by_name, -> {order(:name)}
  scope :published, -> {where(published: true)}
  scope :visible, -> {where(hidden: false)}
end
