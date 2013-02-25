class Transaction < ActiveRecord::Base
  attr_accessible :customer_id, :notify_premium, :premium, :price, :tier_id, :user_id, :email,:stripe_card_token
  validates_presence_of :email
  validate :email, :presence => true
  
  attr_accessor :stripe_card_token
  
  def payment(tier, price, premium, notify_premium)
    if valid?
      if tier
        if tier == 1
          amount = 500
        elsif tier == 2
          amount = 1000
        elsif tier == 3
          amount = 2000
        elsif tier == 4
          amount = 5000
        end
      elsif price
        amount = price*100
      else
        return
      end
      if premium
        amount += 200
      elsif notify_premium
        amount += notify_premium*100
      end
      Stripe::Charge.create(:amount => amount, :currency => "usd", :card => stripe_card_token)
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end
  
  
end
