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
#  fk__answers_contact_id                        (contact_id)
#  fk__answers_location_id                       (location_id)
#  index_answers_on_question_id                  (question_id)
#  index_answers_on_question_id_and_contact_id   (question_id,contact_id) UNIQUE
#  index_answers_on_question_id_and_location_id  (question_id,location_id) UNIQUE
#  index_answers_on_question_id_and_text         (question_id,text) UNIQUE
#

FactoryGirl.define do
  factory :answer do
    
  end

end
