# == Schema Information
#
# Table name: scenarios
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :text             not null
#  solution    :text             not null
#  par         :integer          default(0), not null
#  published   :boolean          default(FALSE), not null
#  universe_id :integer          not null
#  user_id     :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  plays_count :integer          default(0), not null
#
# Indexes
#
#  index_scenarios_on_universe_id  (universe_id)
#  index_scenarios_on_user_id      (user_id)
#

FactoryGirl.define do
  factory :scenario do
    sequence(:name) {|n| "name#{n}"}
    description 'description'
    solution    'solution'
    association :universe
    association :user
  end
end
