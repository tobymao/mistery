class Payments::Product < ActiveRecord::Base
  belongs_to :purchasable, polymorphic: true
end
