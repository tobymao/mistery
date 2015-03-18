# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  question_id :integer          not null
#  correct     :boolean          default("true"), not null
#  location_id :integer
#  contact_id  :integer
#  text        :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_answers_on_question_id                  (question_id)
#  index_answers_on_question_id_and_contact_id   (question_id,contact_id) UNIQUE
#  index_answers_on_question_id_and_location_id  (question_id,location_id) UNIQUE
#  index_answers_on_question_id_and_text         (question_id,text) UNIQUE
#

class Answer < ActiveRecord::Base
  belongs_to :question, inverse_of: :answers
  belongs_to :location
  belongs_to :suspect

  validates_presence_of :question_id
  validates_presence_of :location, :if => lambda {|a| !a.suspect_id && text.nil?}
  validates_presence_of :suspect, :if => lambda {|a| !a.location_id && a.text.nil?}
  validates_presence_of :text, allow_blank: false, :if => lambda {|a| !a.location_id && !a.suspect_id}

  def text=(new_text)
    super(new_text) if new_text.present? && new_text.strip.present?
  end
end
