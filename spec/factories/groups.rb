# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :group do
    name "MyString"
    description "MyText"
    # group_category_id 1
    association :group_category
    association :user_id
    #user_id 1
    private false
    latitude 1.5
    longitude 1.5
    zipcode 1
    password "MyString"
  end
end
