# == Schema Information
#
# Table name: actions
#
#  id          :integer          not null, primary key
#  play_id     :integer          not null
#  location_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_actions_on_play_id_and_location_id  (play_id,location_id) UNIQUE
#

require 'rails_helper'

describe Action do
  let(:user){create(:user)}
  let(:universe){create(:universe, user: user)}
  let(:location){create(:location, universe: universe)}
  let(:scenario){create(:scenario, user: user, universe: universe)}
  let(:play){create(:play, user: user, scenario: scenario)}

  it 'should create' do
    action = Action.new
    action.play = play
    action.location = location
    expect(action.save).to be_truthy
  end

  it 'should validate play' do
    action = Action.new
    action.location = location
    expect(action.save).to be_falsey
  end

  it 'should validate location' do
    action = Action.new
    action.location = location
    expect(action.save).to be_falsey
  end
end
