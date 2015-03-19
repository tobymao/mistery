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

FactoryGirl.define do
  factory :user do
    sequence(:login) {|n| "user#{n}"}
    sequence(:email) {|n| "user#{n}@example.com"}
    password "password"
    guest     false
    admin     false
  end
end
