class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :stripe_customer_id
  include Clearance::User
  has_many :posts
  has_many :groups_as_member, :through => :memberships, :source => :group, :class_name => "Group", :foreign_key => :user_id
  has_many :groups_as_owner, :class_name => "Group"
  validates_uniqueness_of :password, :email
  validates :email, :email_format => true, :presence => true
  attr_accessor :stripe_card_token
  
  def save_with_payment
    if valid?
      customer = Stripe::Customer.create( :description => email, :card => stripe_card_token )
      self.stripe_customer_id = customer.id
      save!
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end
  
  def payment(charge)
    if valid?
      customer = Stripe::Customer.retrieve(self.stripe_customer_token)     
      Stripe::Charge.create(:amount => amount, :currency => "usd", :customer => customer.id)
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end
  
  def post_feed
    groups_as_owner = self.groups_as_owner
    groups_member = self.groups_as_member
    groups = groups_as_owner + groups_member
    Post.from_groups_user_is_member_of(groups)
  end
  
  def group_feed
    groups_as_owner = self.groups_as_owner
    groups_member = self.groups_as_member
    groups = groups_as_owner + groups_member
  end
end
