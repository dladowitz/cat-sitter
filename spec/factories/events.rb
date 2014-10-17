# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    name       "Startup Weekend"
    location   "The Hub"
    start_date 1.day.from_now
    end_date   3.days.from_now
  end
end
