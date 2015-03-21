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

require 'rails_helper'

describe Question do
  let(:scenario) {create(:scenario)}

  it 'should create' do
    question = Question.new
    question.text = 'question'
    question.points = 25
    question.scenario = scenario
    expect(question.save).to be_truthy
  end

  it 'should validate text' do
    question = Question.new
    question.points = 25
    question.scenario = scenario
    expect(question.save).to be_falsey
  end

  it 'should validate points' do
    question = Question.new
    question.text = 'question'
    question.scenario = scenario
    expect(question.save).to be_falsey
  end

  let(:question) {create(:question, scenario: scenario)}
  let(:location) {create(:location)}
  let(:suspect) {create(:suspect, scenario: scenario)}
  let(:multi_answer) {create(:answer, question: question, text: 'blah')}
  let(:suspect_answer) {create(:answer, question: question, suspect: suspect)}
  let(:location_answer) {create(:answer, question: question, location: location)}

  describe '.multiple_choice?' do
    it 'should be true' do
      question.category = Question::CATEGORY_MULTIPLE_CHOICE
      expect(question.multiple_choice?).to be_truthy
    end

    it 'should be false' do
      question.category = Question::CATEGORY_SUSPECT
      expect(question.multiple_choice?).to be_falsey
    end
  end

  describe '.suspect?' do
    it 'should be true' do
      question.category = Question::CATEGORY_SUSPECT
      expect(question.suspect?).to be_truthy
    end

    it 'should be false' do
      question.category = Question::CATEGORY_LOCATION
      expect(question.suspect?).to be_falsey
    end

    it 'should be false with location' do
      question.category = Question::CATEGORY_LOCATION
      expect(question.suspect?).to be_falsey
    end
  end

  describe '.location?' do
    it 'should be true' do
      question.category = Question::CATEGORY_LOCATION
      expect(question.location?).to be_truthy
    end

    it 'should be false' do
      expect(question.location?).to be_falsey
    end

    it 'should be false with multi' do
      question.category = Question::CATEGORY_MULTIPLE_CHOICE
      expect(question.location?).to be_falsey
    end
  end
end
