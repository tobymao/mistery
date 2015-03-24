class Payments::Profile < ActiveRecord::Base
  belongs_to :user, inverse_of: :payment_profile
end
