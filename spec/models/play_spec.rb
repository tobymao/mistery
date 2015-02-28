# == Schema Information
#
# Table name: plays
#
#  id          :integer          not null, primary key
#  active      :boolean          not null
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
  let(:universe) {create(:universe, user: user)}
  let(:scenario) {create(:scenario, user: user, universe: universe)}

  it 'should create with play' do
    play = Play.new
    play.user = user
    play.scenario = scenario
    expect(play.save).to be_truthy
  end
end
