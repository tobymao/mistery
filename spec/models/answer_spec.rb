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

require 'rails_helper'

describe Answer do
  let(:location) {create(:location)}
  let(:suspect) {create(:suspect)}
  let(:question) {create(:question)}
  let(:suspect_question) {create(:question, category: Question::CATEGORY_SUSPECT)}
  let(:location_question) {create(:question, category: Question::CATEGORY_LOCATION)}
  let(:mc_question) {create(:question, category: Question::CATEGORY_MULTIPLE_CHOICE)}

  it 'should create with text' do
    answer = Answer.new
    answer.question = mc_question
    answer.text = "answer"
    expect(answer.save).to be_truthy
  end

  it 'should create with location' do
    answer = Answer.new
    answer.question = location_question
    answer.location = location
    expect(answer.save).to be_truthy
  end

  it 'should create with suspect' do
    answer = Answer.new
    answer.question = suspect_question
    answer.suspect = suspect
    expect(answer.save).to be_truthy
  end
end
