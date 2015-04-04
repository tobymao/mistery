class Payments::Order < ActiveRecord::Base
  belongs_to :user, inverse_of: :orders
  has_many :order_items, inverse_of: :order, class_name: 'Payments::OrderItem'
  has_many :notifications, inverse_of: :order, class_name: 'Payments::Notification'

  STATUS_NEW = 'new'
  STATUS_FAILED = 'failed'
  STATUS_COMPLETED = 'completed'
end
