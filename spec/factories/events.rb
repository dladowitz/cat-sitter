# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    name "MyString"
    location "MyString"
    start_date "2014-10-01 20:15:57"
    end_date "2014-10-01"
  end
end
