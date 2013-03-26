class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :stripe_customer_id
  include Clearance::User
  has_many :transactions
  has_many :posts
  has_many :groups_as_member, :through => :memberships, :source => :group, :class_name => "Group", :foreign_key => :user_id
  has_many :groups_as_owner, :class_name => "Group"
  has_many :memberships, :dependent => :destroy, :foreign_key => :member_id
  validates_uniqueness_of :password, :email
  validates :email, :email_format => true, :presence => true
  

  
  def payment(amount)
    customer = Stripe::Customer.retrieve(self.stripe_customer_id)     
    Stripe::Charge.create(:amount => amount*100, :currency => "usd", :customer => customer)
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while charging cardr: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    
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
