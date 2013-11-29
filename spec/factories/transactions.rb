FactoryGirl.define do
  factory :transaction do
    price 10
    tier_id 1 
    premium "true"
    notify_premium 1
    association :user
    customer_id nil
    sequence(:email) { |n| "johndoe#{n}@example.com"}
    post_id 1


  end
end