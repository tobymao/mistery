class Payments::OrderItem < ActiveRecord::Base
  belongs_to :order, inverse_of: :order_items, class_name: 'Payments::Order'
  belongs_to :product, inverse_of: :order_items, class_name: 'Payments::Product'
end
