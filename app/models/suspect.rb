# == Schema Information
#
# Table name: suspects
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  scenario_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_suspects_on_scenario_id_and_name  (scenario_id) UNIQUE
#

class Suspect < ActiveRecord::Base
  belongs_to :scenario, inverse_of: :suspects
  validates_presence_of :name, :scenario
end
