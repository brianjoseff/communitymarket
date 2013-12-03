# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :followship do
    follower_id 1
    followed_id 1
  end
end
