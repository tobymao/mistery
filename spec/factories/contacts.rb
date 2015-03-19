# == Schema Information
#
# Table name: contacts
#
#  id          :integer          not null, primary key
#  text        :text
#  scenario_id :integer          not null
#  location_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_contacts_on_scenario_id_and_location_id  (scenario_id,location_id) UNIQUE
#

FactoryGirl.define do
  factory :contact do
    text "contact text"
    association :scenario
    association :location
  end
end
