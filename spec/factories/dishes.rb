# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :dish do
    association :meal
    name            "Bahn Mi Sandwiches"
    vegetarian      nil
    vegan           nil
    gluten_free     nil
    external_vendor nil
  end
end
