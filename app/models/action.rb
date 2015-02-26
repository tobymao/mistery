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
#  fk__actions_location_id                   (location_id)
#  fk__actions_play_id                       (play_id)
#  index_actions_on_play_id_and_location_id  (play_id,location_id) UNIQUE
#

class Action < ActiveRecord::Base
  belongs_to :play, inverse_of: :actions
  belongs_to :location
  validates_presence_of :play, :location
end
