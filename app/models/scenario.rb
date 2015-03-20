# == Schema Information
#
# Table name: scenarios
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :text             not null
#  solution    :text             not null
#  par         :integer          default(0), not null
#  published   :boolean          default(FALSE), not null
#  universe_id :integer          not null
#  user_id     :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  plays_count :integer          default(0), not null
#
# Indexes
#
#  index_scenarios_on_universe_id  (universe_id)
#  index_scenarios_on_user_id      (user_id)
#

class Scenario < ActiveRecord::Base
  belongs_to :user, inverse_of: :scenarios
  belongs_to :universe, inverse_of: :scenarios
  has_many :contacts, inverse_of: :scenario
  has_many :suspects, inverse_of: :scenario
  has_many :questions, inverse_of: :scenario
  has_many :plays, inverse_of: :scenario
  has_many :locations, through: :universe

  validates_presence_of :name, :description, :solution, :universe, :user
  accepts_nested_attributes_for :contacts
  accepts_nested_attributes_for :suspects, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :questions, allow_destroy: true, reject_if: :all_blank

  scope :published, -> {where(published: true)}
end
