FactoryGirl.define do
  factory :user do
    login    "test"
    email    "test@example.com"
    password "password"
    guest     false
    admin     false
  end
end
