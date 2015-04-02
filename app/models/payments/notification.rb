class Payments::Notification < ActiveRecord::Base
  belongs_to :order, inverse_of: :notifications, class_name: 'Payments::Order'
  serialize :params, JSON
end
