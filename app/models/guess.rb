# == Schema Information
#
# Table name: guesses
#
#  id          :integer          not null, primary key
#  play_id     :integer          not null
#  question_id :integer          not null
#  answer_id   :integer
#  location_id :integer
#  contact_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_guesses_on_play_id      (play_id)
#  index_guesses_on_question_id  (question_id)
#

class Guess < ActiveRecord::Base
  belongs_to :play, inverse_of: :guesses
  belongs_to :question
  belongs_to :answer
  belongs_to :location
  belongs_to :contact

  validates_presence_of :play, :question
  validate :any_answer

  def points
    points = nil

    if answer.correct ||
       (contact_id && contact_id == question.answer.contact_id) ||
       (location_id && location_id == question.answer.location_id)
      points = question.points
    end

    points
  end

  def guess_string
    if answer
      answer.text
    elsif contact_id
      contact.name
    elsif location_id
      location.name
    else
      raise "Unknown answer type."
    end
  end

  private
  def any_answer
    if !answer && !location && !contact
      errors.add(:base, "Need to have an answer, location, or contact.")
    end
  end
end
