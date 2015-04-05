# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  login      :string
#  email      :string
#  password   :string
#  guest      :boolean          default(FALSE), not null
#  admin      :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  has_many :sessions, inverse_of: :user
  has_many :universes, inverse_of: :user
  has_many :scenarios, inverse_of: :user
  has_many :plays, inverse_of: :user
  has_many :password_resets, inverse_of: :user
  # payments
  has_many :orders, inverse_of: :user, class_name: 'Payments::Order'
  has_many :purchases, inverse_of: :user, class_name: 'Payments::Purchase'
  has_one  :payment_profile, inverse_of: :user, class_name: 'Payments::Profile'

  validates_presence_of :login, message: "Username is required", unless: :guest
  validates_presence_of :email, message: "Email is required", unless: :guest
  validates_presence_of :password, message: "Password is required", unless: :guest
  validates_uniqueness_of :login, message: "Username is taken", case_sensitive: false, unless: :guest
  validates_uniqueness_of :email, message: "Email is already registered", case_sensitive: false, unless: :guest

  def self.new_guest_user
    User.new({guest: true})
  end

  def purchased?(product)
    purchases.where(purchased: product).exists?
  end

  def password
    pass = read_attribute(:password)
    BCrypt::Password.new(pass) if pass
  end

  def password=(new_password)
    return if new_password.empty?
    super(BCrypt::Password.create(new_password))
  end
end
