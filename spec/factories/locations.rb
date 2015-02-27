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
#  index_locations_on_universe_id_and_address  (universe_id,address) UNIQUE
#

FactoryGirl.define do
  factory :location do
    address 'a1'
    name 'location'
    association :universe
  end
end
