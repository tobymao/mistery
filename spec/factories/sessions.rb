# == Schema Information
#
# Table name: sessions
#
#  id         :integer          not null, primary key
#  token      :string           not null
#  ip_address :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :session do
    token 'test_token'
    ip_address '127.0.0.1'
    association :user
  end
end
