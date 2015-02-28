# == Schema Information
#
# Table name: guesses
#
#  id          :integer          not null, primary key
#  play_id     :integer          not null
#  question_id :integer          not null
#  answer_id   :integer
#  location_id :integer
#  guess_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_guesses_on_play_id      (play_id)
#  index_guesses_on_question_id  (question_id)
#

require 'rails_helper'

describe Guess do
  let(:user) {create(:user)}
  let(:universe) {create(:universe, user: user)}
  let(:scenario) {create(:scenario, user: user, universe: universe)}
  let(:location) {create(:location, universe: universe)}
  let(:contact) {create(:contact, scenario: scenario)}
  let(:question) {create(:question, scenario: scenario)}
  let(:play) {create(:play, user: user, scenario: scenario)}
  let(:answer) {create(:answer, question: question, text: 'answer')}

  it 'should create with location' do
    guess = Guess.new
    guess.play = play
    guess.question = question
    guess.location = location
    expect(guess.save).to be_truthy
  end

  it 'should create with answer' do
    guess = Guess.new
    guess.play = play
    guess.question = question
    guess.answer = answer
    expect(guess.save).to be_truthy
  end

  it 'should create with contact' do
    guess = Guess.new
    guess.play = play
    guess.question = question
    guess.contact = contact
    expect(guess.save).to be_truthy
  end

  it 'should validate any answer' do
    guess = Guess.new
    guess.play = play
    guess.question = question
    expect(guess.save).to be_falsey
  end

  it 'should create with play' do
    guess = Guess.new
    guess.question = question
    guess.location = location
    expect(guess.save).to be_falsey
  end

  it 'should create with question' do
    guess = Guess.new
    guess.play = play
    guess.location = location
    expect(guess.save).to be_falsey
  end
end
