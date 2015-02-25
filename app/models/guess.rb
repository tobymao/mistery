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
#  fk__guesses_answer_id         (answer_id)
#  fk__guesses_contact_id        (contact_id)
#  fk__guesses_location_id       (location_id)
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
end
