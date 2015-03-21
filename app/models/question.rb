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
  has_many :answers, inverse_of: :question, dependent: :destroy

  validates_presence_of :text, :points
  after_update :category_changed, if: :category_changed?

  accepts_nested_attributes_for :answers, allow_destroy: true

  CATEGORY_UNKNOWN = 0
  CATEGORY_SUSPECT = 1
  CATEGORY_LOCATION = 2
  CATEGORY_MULTIPLE_CHOICE = 3
  CATEGORIES = [CATEGORY_SUSPECT, CATEGORY_LOCATION, CATEGORY_MULTIPLE_CHOICE]

  CATEGORY_STRING = {
    CATEGORY_UNKNOWN => 'Unknown',
    CATEGORY_MULTIPLE_CHOICE => 'Multiple Choice',
    CATEGORY_SUSPECT => 'Suspect',
    CATEGORY_LOCATION => 'Location',
  }

  def self.categories
    CATEGORIES.map do |c|
      category = OpenStruct.new
      category.id = c
      category.name = CATEGORY_STRING[c]
      category
    end
  end

  def category_string
    CATEGORY_STRING[category]
  end

  def answer
    answers.find(&:correct)
  end

  def answer_string
    return '' if !answer

    if multiple_choice?
      answer.text
    elsif suspect?
      answer.suspect.name
    elsif location?
      answer.location.name
    end
  end

  def multiple_choice?
    category == CATEGORY_MULTIPLE_CHOICE
  end

  def suspect?
    category == CATEGORY_SUSPECT
  end

  def location?
    category == CATEGORY_LOCATION
  end

  private
  def category_changed
    answers.each {|answer| answer.destroy}
  end
end
