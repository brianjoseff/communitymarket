# t.string   "email"
# t.string   "name"
# t.datetime "created_at",                        :null => false
# t.datetime "updated_at",                        :null => false
# t.string   "encrypted_password", :limit => 128
# t.string   "salt",               :limit => 128
# t.string   "confirmation_token", :limit => 128
# t.string   "remember_token",     :limit => 128
# t.string   "stripe_customer_id"
# t.string   "password"
# t.boolean  "admin"

FactoryGirl.define do
  factory :user do
    email "brian@brian.com"
    name "Brian David"
    admin "true"
    password "000000"
  end
end