require 'factory_girl'
FactoryGirl.define do
  sequence(:user_id) do |n|
    "100009845#{n}".to_i
  end
  
  factory :tab do
    title 'Smoke on the water'
    user_id
    content '1|0-2|2 1|3-2|5 1|5-2|7 1|0 1|3 1|6 1|5'
  end
end