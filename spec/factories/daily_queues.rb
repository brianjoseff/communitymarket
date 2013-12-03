# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :daily_queue do
    post_id 1
    user_id 1
    group_id 1
    sender_id 1
  end
end
