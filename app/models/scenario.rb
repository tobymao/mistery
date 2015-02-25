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
#  index_scenarios_on_name         (name) UNIQUE
#  index_scenarios_on_universe_id  (universe_id)
#  index_scenarios_on_user_id      (user_id)
#

class Scenario < ActiveRecord::Base
  belongs_to :user, inverse_of: :scenarios
  belongs_to :universe, inverse_of: :scenarios
  has_many :contacts, inverse_of: :scenario
  has_many :questions, inverse_of: :scenario
  has_many :plays, inverse_of: :scenario
  has_many :locations, through: :universe
end
