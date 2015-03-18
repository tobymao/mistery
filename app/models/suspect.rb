class Suspect < ActiveRecord::Base
  belongs_to :scenario, inverse_of: :suspects
  validates_presence_of :name, :scenario
end
