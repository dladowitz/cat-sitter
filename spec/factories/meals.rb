# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :meal do
    association :event
    name       "Dinner"
    head_count 100
    start_time 2.days.from_now
  end
end
