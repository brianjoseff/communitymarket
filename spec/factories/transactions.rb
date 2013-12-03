# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :transaction do
    price 1
    tier_id 1
    premium false
    notify_premium 1
    user_id 1
  end
end
