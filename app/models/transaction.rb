class Transaction < ActiveRecord::Base
  attr_accessible :customer_id, :notify_premium, :premium, :price, :tier_id, :user_id, :email,:stripe_card_token
  validates :email, :presence => true, :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
  #validate :email, :presence => true
  belongs_to :user
  
  attr_accessor :stripe_card_token
  
  def payment(tier, price, premium, notify_premium)
    if valid?
      if tier.present?
        if tier == 1
          amount = 500
        elsif tier == 2
          amount = 1000
        elsif tier == 3
          amount = 2000
        elsif tier == 4
          amount = 5000
        end
      elsif price.present?
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
  #misnomer, where is the paymenet? When does that occur?
  def save_with_payment
    p stripe_card_token
    if valid?
      customer = Stripe::Customer.create( :description => email, :card => stripe_card_token )
      customer.id
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end
  
end
