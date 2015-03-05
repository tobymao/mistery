# == Schema Information
#
# Table name: plays
#
#  id          :integer          not null, primary key
#  active      :boolean          default("false"), not null
#  points      :integer
#  user_id     :integer          not null
#  scenario_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_plays_on_scenario_id  (scenario_id)
#  index_plays_on_user_id      (user_id)
#

require 'rails_helper'

describe Play do
  let(:user) {create(:user)}
  let(:scenario) {create(:scenario, user: user)}

  it 'should create' do
    play = Play.new
    play.user = user
    play.scenario = scenario
    expect(play.save).to be_truthy
  end

  it 'should create with points' do
    play = Play.new
    play.user = user
    play.scenario = scenario
    play.points = 25
    expect(play.save).to be_truthy
  end

  it 'should create with active' do
    play = Play.new
    play.user = user
    play.scenario = scenario
    play.active = true
    expect(play.save).to be_truthy
  end

  it 'should validate user' do
    play = Play.new
    play.scenario = scenario
    expect(play.save).to be_falsey
  end

  it 'should validate scenario' do
    play = Play.new
    play.scenario = scenario
    expect(play.save).to be_falsey
  end
end
