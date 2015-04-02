class Payments::Product < ActiveRecord::Base
  has_many :order_items, inverse_of: :product
  belongs_to :purchasable, polymorphic: true, class_name: 'Payments::Product'
end
