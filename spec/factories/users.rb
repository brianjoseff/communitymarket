# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email "MyString"
    name "MyString"
    stripe_customer_id "MyString"
  end
end
