# == Schema Information
#
# Table name: plays
#
#  id          :integer          not null, primary key
#  active      :boolean          default(FALSE), not null
#  points      :integer
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

class Play < ActiveRecord::Base
  belongs_to :user, inverse_of: :plays
  belongs_to :scenario, inverse_of: :plays, counter_cache: true
  has_many :actions, inverse_of: :play
  has_many :guesses, inverse_of: :play
  accepts_nested_attributes_for :guesses, allow_destroy: true, reject_if: :all_blank
  validates_presence_of :user, :scenario

  LOCATION_PENTALTY = 5
end
