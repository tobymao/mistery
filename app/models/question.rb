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
# Indexes
#
#  index_questions_on_scenario_id  (scenario_id)
#

class Question < ActiveRecord::Base
  belongs_to :scenario, inverse_of: :questions
  has_many :answers, inverse_of: :question
  validates_presence_of :text, :points
  accepts_nested_attributes_for :answers, allow_destroy: true

  def multiple_choice?
    answers.first.text.present?
  end

  def contact?
    !!answers.first.contact
  end

  def location?
    !!answers.first.location
  end
end
