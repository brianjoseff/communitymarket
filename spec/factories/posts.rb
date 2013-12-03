# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    title "MyString"
    borrow false
    tier_id 1
    description "MyText"
    user_id 1
    post_category_id 1
    premium false
    cash false
    price 1
    active false
  end
end
