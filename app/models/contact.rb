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

class Contact < ActiveRecord::Base
  belongs_to :location
  belongs_to :scenario, inverse_of: :contacts

  validates_presence_of :location, :scenario

  def text=(new_text)
    super(new_text.present? ? new_text : nil)
  end
end
