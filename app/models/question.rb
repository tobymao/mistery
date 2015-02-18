# == Schema Information
#
# Table name: questions
#
#  id              :integer          not null, primary key
#  text            :text             not null
#  multiple_choice :boolean          default("false"), not null
#  scenario_id     :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Question < ActiveRecord::Base
  belongs_to: :scenario, inverse_of: :questions
end
