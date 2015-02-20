# == Schema Information
#
# Table name: questions
#
#  id          :integer          not null, primary key
#  text        :text             not null
#  points      :integer          not null
#  scenario_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

describe Question do
end
