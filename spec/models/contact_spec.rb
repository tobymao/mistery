# == Schema Information
#
# Table name: contacts
#
#  id          :integer          not null, primary key
#  text        :text
#  scenario_id :integer          not null
#  location_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_contacts_on_scenario_id_and_location_id  (scenario_id,location_id) UNIQUE
#

require 'rails_helper'

describe Contact do
  let(:scenario) {create(:scenario)}
  let(:location) {create(:location)}

  it 'should create' do
    contact = Contact.new
    contact.text = "contact"
    contact.scenario = scenario
    contact.location = location
    expect(contact.save).to be_truthy
  end

  it 'should not create without location' do
    contact = Contact.new
    contact.text = "contact"
    contact.scenario = scenario
    expect(contact.save).to be_falsey
  end

  it 'should not create without text and location' do
    contact = Contact.new
    contact.scenario = scenario
    expect(contact.save).to be_falsey
  end

  it 'should not create without name or location' do
    contact = Contact.new
    contact.text = "contact"
    contact.scenario = scenario
    expect(contact.save).to be_falsey
  end

  it 'should create without text in a location' do
    contact = Contact.new
    contact.location = location
    contact.scenario = scenario
    expect(contact.save).to be_truthy
  end

  it 'should validate scenario' do
    contact = Contact.new
    contact.text = "contact"
    contact.location = location
    expect(contact.save).to be_falsey
  end
end
