class Transaction < ActiveRecord::Base
  attr_accessible :customer_id, :notify_premium, :premium, :price, :tier_id, :user_id, :email,:stripe_card_token, :post_id
  validates :email, :presence => true, :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
  validates :price, :presence => true
  validates :post_id, :presence => true
  #validate :email, :presence => true
  belongs_to :user
  
  attr_accessor :stripe_card_token
  
  def save_customer(user)
    if valid?
      customer = Stripe::Customer.create( :description => email, :card => stripe_card_token)
      user.stripe_customer_id = customer.id
      user.save!
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "NO MAMES, Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end
  
  def charge(amount, token, email)
    Stripe::Charge.create(:amount => amount, :currency => "usd", :card => token, :description => email)
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while charging card: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end
  
  def payment(tier, price, user)
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
      # if premium
      #         amount += 200
      #       elsif notify_premium
      #         amount += notify_premium*100
      #       end
      Stripe::Charge.create(:amount => amount, :currency => "usd", :customer => user.stripe_customer_id)
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while charging: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end
  # def save_customer(token)
  #   # p stripe_card_token
  #   if valid?
  #     customer = Stripe::Customer.create( :description => email, :card => token )
  #     customer.id
  #   end
  # rescue Stripe::InvalidRequestError => e
  #   logger.error "Stripe error while creating customer: #{e.message}"
  #   errors.add :base, "There was a problem with your credit card."
  #   false
  # end
  
  #misnomer, where is the paymenet? When does that occur?
  # def save_customer_with_payment(tier,price)
  #     p stripe_card_token
  #     if valid?
  #       customer = Stripe::Customer.create( :description => email, :card => stripe_card_token )
  #       if tier.present?
  #         if tier == 1
  #           amount = 500
  #         elsif tier == 2
  #           amount = 1000
  #         elsif tier == 3
  #           amount = 2000
  #         elsif tier == 4
  #           amount = 5000
  #         end
  #       elsif price.present?
  #         amount = price*100
  #       else
  #         return
  #       end
  #     end
  #   rescue Stripe::InvalidRequestError => e
  #     logger.error "Stripe error while creating customer: #{e.message}"
  #     errors.add :base, "There was a problem with your credit card."
  # 
  #     Stripe::Charge.create(:amount => amount, :currency => "usd", :card => customer.id)
  #   rescue Stripe::InvalidRequestError => e
  #     logger.error "Stripe error while charging: #{e.message}"
  #     errors.add :base, "There was a problem with your credit card."
  #     false
  #   end

end
