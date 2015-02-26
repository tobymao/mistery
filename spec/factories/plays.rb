# == Schema Information
#
# Table name: plays
#
#  id          :integer          not null, primary key
#  active      :boolean          not null
#  user_id     :integer          not null
#  scenario_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_plays_on_scenario_id  (scenario_id)
#  index_plays_on_user_id      (user_id)
#

FactoryGirl.define do
  factory :play do
    active      true
    association :user
    association :scenario
  end
end
