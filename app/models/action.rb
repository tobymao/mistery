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

class Action < ActiveRecord::Base
end
