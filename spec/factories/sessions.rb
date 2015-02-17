FactoryGirl.define do
  factory :session do
    token 'test_token'
    ip_address '127.0.0.1'
    association :user
  end
end
