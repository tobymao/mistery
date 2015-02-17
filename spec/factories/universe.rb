FactoryGirl.define do
  factory :universe do
    name 'test name'
    description 'test description'
    association :user
  end
end
