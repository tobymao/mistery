class Payments::Purchase < ActiveRecord::Base
  belongs_to :user, inverse_of: :purchases
  belongs_to :purchased, polymorphic: true
end
