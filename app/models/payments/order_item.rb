class Payments::OrderItem < ActiveRecord::Base
  belongs_to :order, inverse_of: :order_items
  belongs_to :product, inverse_of: :order_items
end
