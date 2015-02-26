# == Schema Information
#
# Table name: scenarios
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  solution    :text
#  universe_id :integer          not null
#  user_id     :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_scenarios_on_universe_id  (universe_id)
#  index_scenarios_on_user_id      (user_id)
#

FactoryGirl.define do
  factory :scenario do
    name        'test scenario'
    description 'a scenario for a test'
    solution    'the solution'
    association :universe
    association :user
  end
end
