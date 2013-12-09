# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :asset do
    imageable_id 1
    imageable_type "MyString"
  end
end

FactoryGirl.define do  
  factory :assignment do
    post_id 1
    group_id 1
  end
end
 
FactoryGirl.define do  
  factory :daily_queue do
    post_id 1
    user_id 1
    group_id 1
    sender_id 1
  end
end

FactoryGirl.define do  
  factory :followship do
    follower_id 1
    followed_id 1
  end
end

FactoryGirl.define do  
  factory :group_category do
    name "MyString"
  end
end
FactoryGirl.define do 
  sequence :email do |n|
    "user#{n}@example.com"
  end
  factory :user do
    email
    name "Name"
    password "password"
  end
  
end
FactoryGirl.define do  
  factory :group do
    name "MyString"
    description "MyText"
    group_category
    #user
    private false
    latitude 1.5
    longitude 1.5
    zipcode 1
    #password "MyString"
    factory :group_with_members do
      after(:create) do |group|
        group.members << create(:user)
      end
    end
  end
  
end

FactoryGirl.define do  
  factory :image do
    user_id 1
  end
end

FactoryGirl.define do  
  factory :membership do
    group_id 1
    member_id 1
    email_setting_id 1
  end
end

FactoryGirl.define do  
  factory :post_category do
    name "Post category"
  end
end
  
FactoryGirl.define do
  factory :tagging do
    tag_id ""
    post_id 1
  end
end

FactoryGirl.define do  
  factory :tag do
    name "MyString"
    description "MyText"
  end
end

FactoryGirl.define do 
  factory :tier do
    name "Trinket"
    price 1
  end 
end

FactoryGirl.define do  
  factory :transaction do
    price 1
    tier_id 1
    premium false
    notify_premium 1
    user_id 1
  end
end
  

  


FactoryGirl.define do
  factory :weekly_queue do
    post_id 1
    user_id 1
    group_id 1
    sender_id 1
  end
end



FactoryGirl.define do
  factory :post do
    title "Post Title"
    borrow false
    association :tier
    description "MyText"
    association :user
    association :post_category
    premium false
    cash false
    price 1
    active false
  end
end  
