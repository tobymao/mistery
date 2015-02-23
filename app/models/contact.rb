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

class Contact < ActiveRecord::Base
  belongs_to :location
  belongs_to :scenario, inverse_of: :contacts
  validates_presence_of :scenario
end
