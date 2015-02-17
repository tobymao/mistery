# == Schema Information
#
# Table name: universes
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  text       :text
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

describe Universe do
  let(:user) {create(:user)}

  it 'should create' do
    universe = Universe.new
    universe.name = "universe1"
    universe.description = "awesome universe"
    universe.user = user
    expect(universe.save).to be_truthy
  end

  it 'should validate name' do
    universe = Universe.new
    universe.description = "awesome universe"
    universe.user = user
    expect(universe.save).to be_falsey
  end

  it 'should validate user' do
    universe = Universe.new
    universe.name = "universe1"
    universe.description = "awesome universe"
    expect(universe.save).to be_falsey
  end
end
