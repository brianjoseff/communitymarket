class Transaction < ActiveRecord::Base
  attr_accessible :customer_id, :notify_premium, :premium, :price, :tier_id, :user_id, :email,:stripe_card_token
  validates :email, :presence => true, :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
  #validates :email, :presence => true, :uniqueness => true
  #validates :stripe_card_token, :presence => true
  attr_accessor :stripe_card_token


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