FactoryGirl.define do
  factory :user do
    login    "test"
    email    "test@example.com"
    fname    "first"
    lname    "last"
    password "password"
  end
end
