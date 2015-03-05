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
#
# Indexes
#
#  index_locations_on_universe_id_and_name  (universe_id) UNIQUE
#

FactoryGirl.define do
  factory :location do
    sequence(:name) {|n| "location#{n}"}
    group 'group'
    association :universe
  end
end
