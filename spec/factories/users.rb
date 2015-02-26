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

FactoryGirl.define do
  factory :user do
    login    "test"
    email    "test@example.com"
    password "password"
    guest     false
    admin     false
  end
end
