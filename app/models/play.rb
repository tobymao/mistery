# == Schema Information
#
# Table name: plays
#
#  id          :integer          not null, primary key
#  active      :boolean          default("false"), not null
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
  belongs_to :scenario, inverse_of: :plays
  has_many :actions, inverse_of: :play
  has_many :guesses, inverse_of: :play
  validates_presence_of :user, :scenario
end
