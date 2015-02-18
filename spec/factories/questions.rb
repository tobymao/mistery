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

FactoryGirl.define do
  factory :question do

  end
end
