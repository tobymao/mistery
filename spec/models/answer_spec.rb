# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  text        :text             not null
#  points      :integer          default("0"), not null
#  question_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

describe Answer do
end
