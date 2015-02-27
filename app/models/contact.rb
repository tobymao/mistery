# == Schema Information
#
# Table name: contacts
#
#  id          :integer          not null, primary key
#  name        :string
#  text        :text
#  scenario_id :integer          not null
#  location_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_contacts_on_scenario_id_and_location_id  (scenario_id,location_id) UNIQUE
#

class Contact < ActiveRecord::Base
  belongs_to :location
  belongs_to :scenario, inverse_of: :contacts

  validates_presence_of :scenario
  validate :name_or_location
  validate :text_and_location

  def name_or_location
    if !name && !location
      errors.add(:base, 'Name or location must be present.')
    end
  end

  def text_and_location
    if location && !text
      errors.add(:text, 'Text must be present when contact attached to location.')
    end
  end
end
