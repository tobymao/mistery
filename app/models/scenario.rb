# == Schema Information
#
# Table name: scenarios
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :text
#  solution    :text
#  universe_id :integer          not null
#  user_id     :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Scenario < ActiveRecord::Base
  has_many :contacts, inverse_of: :scenario
  has_many :questions, inverse_of: :scenario
  has_many :plays, inverse_of: :scenario
  belongs_to :user, inverse_of: :scenarios
  belongs_to :universe, inverse_of: :scenarios
end
