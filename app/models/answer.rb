# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  question_id :integer          not null
#  correct     :boolean          default(TRUE), not null
#  location_id :integer
#  text        :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  suspect_id  :integer
#
# Indexes
#
#  index_answers_on_question_id                  (question_id)
#  index_answers_on_question_id_and_location_id  (question_id,location_id) UNIQUE
#  index_answers_on_question_id_and_text         (question_id,text) UNIQUE
#

class Answer < ActiveRecord::Base
  belongs_to :question, inverse_of: :answers
  belongs_to :location
  belongs_to :suspect

  validates_presence_of :question_id
  validate :check_category

  def text=(new_text)
    super(new_text) if new_text.present? && new_text.strip.present?
  end

  private
  def check_category
    case question.category
    when Question::CATEGORY_SUSPECT
      raise if !suspect_id || location_id || text
    when Question::CATEGORY_LOCATION
      raise if !location_id || suspect_id || text
    when Question::CATEGORY_MULTIPLE_CHOICE
      raise if text.nil? || suspect_id || location_id
    end
  end
end
