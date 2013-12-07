# FactoryGirl.define do 
#   sequence :email do |n|
#      "user#{n}@example.com"
#   end
# 
#   factory :user do
#     email
#     password "password"
#   end
# 
#   factory :email_confirmed_user, :parent => :user do
#     after_build { warn "[DEPRECATION] The :email_confirmed_user factory is deprecated, please use the :user factory instead." }
#   end
# end