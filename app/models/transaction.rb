class Transaction < ActiveRecord::Base
  attr_accessible :customer_id, :notify_premium, :premium, :price, :tier_id, :user_id, :email,:stripe_card_token
  validates :email, :presence => true, :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
  #validate :email, :presence => true
  belongs_to :user
  
  attr_accessor :stripe_card_token
  

  
end
