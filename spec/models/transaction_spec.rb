require 'spec_helper'
require 'factory_girl'

# t.integer  "price"
# t.integer  "tier_id"
# t.boolean  "premium"
# t.integer  "notify_premium"
# t.integer  "user_id"
# t.integer  "customer_id"
# t.datetime "created_at",     :null => false
# t.datetime "updated_at",     :null => false
# t.string   "email"
# t.integer  "post_id"

describe Transaction do
  it "has a valid factory" do
    FactoryGirl.create(:transaction).should be_valid
  end
  # it "is invalid with no credit card entered" do
  #   FactoryGirl.build(:transaction, cardnumber: nil).should_not be_valid
  # it "is invalid with no exp date entered"
  # it "is invalid with no cvc number entered"
  # it "is invalid with the wrong credit card number"
  
  #uses "build" rather than "create" because create build and saves, automatically rbeaking test
  # it "is invalid without user id" do
  #   FactoryGirl.build(:transaction, user_id: nil).should_not be_valid
  # end
  it "is invalid without price" do
    FactoryGirl.build(:transaction, price: nil).should_not be_valid
    
    # below might be the default version now-- above might get deprecated
    #expect(FactoryGirl.build(:transaction, price: nil)).to_not be_valid
  end
  it "is inavlid without post_id" do 
    FactoryGirl.build(:transaction, post_id: nil).should_not be_valid
  end
  it "is invalid without email" do
    FactoryGirl.build(:transaction, email: nil).should_not be_valid
  end
  it "returns to home page"
  pending "add some examples to (or delete) #{__FILE__}"
end
