class Payments::Order < ActiveRecord::Base
  belongs_to :order, inverse_of: :orders
  belongs_to :user, inverse_of: :orders
end
