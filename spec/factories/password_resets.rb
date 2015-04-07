FactoryGirl.define do
  factory :password_reset do
    association :user
    token "token"
  end
end
