# == Schema Information
#
# Table name: guesses
#
#  id          :integer          not null, primary key
#  play_id     :integer          not null
#  question_id :integer          not null
#  answer_id   :integer
#  location_id :integer
#  contact_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Guess < ActiveRecord::Base
end
