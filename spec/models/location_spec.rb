# == Schema Information
#
# Table name: locations
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  group       :string
#  universe_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  hidden      :boolean          default(FALSE), not null
#
# Indexes
#
#  index_locations_on_universe_id_and_name  (universe_id) UNIQUE
#

require 'rails_helper'

describe Location do
  let(:universe) {create(:universe)}

  it 'should create' do
    location = Location.new
    location.group = "a1"
    location.name = "name"
    location.universe = universe
    expect(location.save).to be_truthy
  end

  it 'should create with no group' do
    location = Location.new
    location.name = "name"
    location.universe = universe
    expect(location.save).to be_truthy
  end

  it 'should validate name' do
    location = Location.new
    location.group = "a1"
    location.universe = universe
    expect(location.save).to be_falsey
  end

  it 'should validate universe' do
    location = Location.new
    location.group = "a1"
    location.name = "name"
    expect(location.save).to be_falsey
  end
end
