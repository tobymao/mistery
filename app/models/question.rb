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

class Question < ActiveRecord::Base
  belongs_to :scenario, inverse_of: :questions
  has_many :answers, inverse_of: :question
  accepts_nested_attributes_for :answers, allow_destroy: true
end
