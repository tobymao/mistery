# == Schema Information
#
# Table name: plays
#
#  id          :integer          not null, primary key
#  user_id     :integer          not null
#  scenario_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Play < ActiveRecord::Base
end
