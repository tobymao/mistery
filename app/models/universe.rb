# == Schema Information
#
# Table name: universes
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :text
#  user_id     :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Universe < ActiveRecord::Base
  has_many :locations, inverse_of: :universe
  has_many :scenarios, inverse_of: :universe
  belongs_to :user, inverse_of: :universes
  validates_presence_of :name, :user
  accepts_nested_attributes_for :locations, allow_destroy: true
end
