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

  it 'should create with text' do
    answer = Answer.new
    answer.question = question
    answer.text = "answer"
    expect(answer.save).to be_truthy
  end

  it 'should create with location' do
    answer = Answer.new
    answer.question = question
    answer.location = location
    expect(answer.save).to be_truthy
  end

  it 'should create with suspect' do
    answer = Answer.new
    answer.question = question
    answer.suspect = suspect
    expect(answer.save).to be_truthy
  end

  it 'should validate question' do
    answer = Answer.new
    answer.text = "answer"
    expect(answer.save).to be_falsey
  end

  it 'should validate location, suspect, and text' do
    answer = Answer.new
    answer.question = question
    expect(answer.save).to be_falsey
  end

  it 'should not allow spaces' do
    answer = Answer.new
    answer.text = '  '
    expect(answer.save).to be_falsey
  end

  it 'should not strip nil' do
    answer = Answer.new
    answer.text = nil
    answer.question = question
    expect(answer.save).to be_falsey
  end
end
