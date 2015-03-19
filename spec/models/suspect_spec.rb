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

require 'rails_helper'

describe Suspect do
end
