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
  let(:user) {create(:user)}
  let(:universe) {create(:universe, user: user)}
  let(:scenario) {create(:scenario, user: user, universe: universe)}

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
  let(:location) {create(:location, universe: universe)}
  let(:contact) {create(:contact, scenario: scenario)}
  let(:multi_answer) {create(:answer, question: question, text: 'blah')}
  let(:location_answer) {create(:answer, question: question, location: location)}
  let(:contact_answer) {create(:answer, question: question, contact: contact)}

  describe '.multiple_choice?' do
    it 'should be true' do
      question.answers << multi_answer
      expect(question.multiple_choice?).to be_truthy
    end

    it 'should be false' do
      expect(question.multiple_choice?).to be_falsey
    end

    it 'should be false with contact' do
      question.answers << contact_answer
      expect(question.multiple_choice?).to be_falsey
    end
  end

  describe '.contact?' do
    it 'should be true' do
      question.answers << contact_answer
      expect(question.contact?).to be_truthy
    end

    it 'should be false' do
      expect(question.contact?).to be_falsey
    end

    it 'should be false with location' do
      question.answers << location_answer
      expect(question.contact?).to be_falsey
    end
  end

  describe '.location?' do
    it 'should be true' do
      question.answers << location_answer
      expect(question.location?).to be_truthy
    end

    it 'should be false' do
      expect(question.location?).to be_falsey
    end

    it 'should be false with multi' do
      question.answers << multi_answer
      expect(question.location?).to be_falsey
    end
  end
end
