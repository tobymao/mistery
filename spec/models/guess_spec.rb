# == Schema Information
#
# Table name: guesses
#
#  id          :integer          not null, primary key
#  text        :text
#  play_id     :integer          not null
#  question_id :integer          not null
#  answer_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

describe Guess do
end
