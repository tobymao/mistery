# == Schema Information
#
# Table name: scenarios
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :text             not null
#  solution    :text             not null
#  par         :integer          default("0"), not null
#  published   :boolean          default("false"), not null
#  universe_id :integer          not null
#  user_id     :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_scenarios_on_universe_id  (universe_id)
#  index_scenarios_on_user_id      (user_id)
#

require 'rails_helper'

describe Scenario do
  let(:user) {create(:user)}
  let(:universe) {create(:universe, user: user)}

  it 'should create' do
    scenario = Scenario.new
    scenario.name = "test"
    scenario.description = "description"
    scenario.solution = "solution"
    scenario.universe = universe
    scenario.user = user
    expect(scenario.save).to be_truthy
  end

  it 'should validate name' do
    scenario = Scenario.new
    scenario.description = "description"
    scenario.solution = "solution"
    scenario.universe = universe
    scenario.user = user
    expect(scenario.save).to be_falsey
  end

  it 'should validate description' do
    scenario = Scenario.new
    scenario.name = "test"
    scenario.solution = "solution"
    scenario.universe = universe
    scenario.user = user
    expect(scenario.save).to be_falsey
  end
  it 'should validate solution' do
    scenario = Scenario.new
    scenario.name = "test"
    scenario.description = "description"
    scenario.universe = universe
    scenario.user = user
    expect(scenario.save).to be_falsey
  end
  it 'should validate universe' do
    scenario = Scenario.new
    scenario.name = "test"
    scenario.description = "description"
    scenario.solution = "solution"
    scenario.user = user
    expect(scenario.save).to be_falsey
  end

  it 'should validate user' do
    scenario = Scenario.new
    scenario.name = "test"
    scenario.description = "description"
    scenario.solution = "solution"
    scenario.universe = universe
    expect(scenario.save).to be_falsey
  end
end
