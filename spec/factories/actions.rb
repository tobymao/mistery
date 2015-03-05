# == Schema Information
#
# Table name: actions
#
#  id          :integer          not null, primary key
#  play_id     :integer          not null
#  location_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_actions_on_play_id_and_location_id  (play_id,location_id) UNIQUE
#

FactoryGirl.define do
  factory :action do
    association :play
    association :location
  end
end
