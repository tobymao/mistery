# == Schema Information
#
# Table name: sessions
#
#  id         :integer          not null, primary key
#  token      :string           not null
#  ip_address :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Contact < ActiveRecord::Base
  belongs_to :location
  belongs_to :scenario, inverse_of: :contact
  validates_presence_of :name, :scenario
end
