# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  login      :string
#  email      :string
#  password   :string
#  guest      :boolean          default("false"), not null
#  admin      :boolean          default("false"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#  index_users_on_login  (login) UNIQUE
#

class User < ActiveRecord::Base
  has_many :sessions, inverse_of: :user
  has_many :universes, inverse_of: :user
  has_many :scenarios, inverse_of: :user
  has_many :plays, inverse_of: :user

  validates_presence_of :login, message: "Username is required", unless: :guest
  validates_presence_of :email, message: "Email is required", unless: :guest
  validates_uniqueness_of :login, message: "Username is taken", case_sensitive: false, unless: :guest
  validates_uniqueness_of :email, message: "Email is already registered",case_sensitive: false, unless: :guest

  def self.new_guest_user
    User.new({guest: true})
  end

  def password
    pass = read_attribute(:password)
    BCrypt::Password.new(pass) if pass
  end

  def password=(new_password)
    return if new_password.empty?
    super(BCrypt::Password.create(new_password))
  end

  def email=(new_email)
    super(new_email.downcase)
  end
end
