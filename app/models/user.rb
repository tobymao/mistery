# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  login      :string           not null
#  email      :string
#  password   :string
#  guest      :boolean          default("false"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  has_many :sessions, inverse_of: :user
  has_many :universes, inverse_of: :user
  has_many :scenarios, inverse_of: :user
  has_many :plays, inverse_of: :user
  validates_presence_of :login, message: "Username is required"
  validates_presence_of :email, :password, unless: :guest

  def self.new_guest_user
    # TO DO: Seems really hacky. Should Change.
    User.new({
      login: "guest#{User.last.id+1}",
      guest: true,
    })
  end

  def password
    pass = read_attribute(:password)
    BCrypt::Password.new(pass) if pass
  end

  def password=(new_password)
    return if new_password.empty?
    super(BCrypt::Password.create(new_password))
  end

  def display_name
    guest ? "guest" : login
  end
end
