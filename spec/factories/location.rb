FactoryGirl.define do
  factory :location do
    address 'a1'
    name 'location'
    association :universe
  end
end
