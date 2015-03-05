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
# Indexes
#
#  index_sessions_on_token    (token) UNIQUE
#  index_sessions_on_user_id  (user_id)
#

FactoryGirl.define do
  factory :session do
    sequence(:token) {|n| "token#{n}"}
    ip_address '127.0.0.1'
    association :user
  end
end
