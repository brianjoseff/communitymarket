class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :stripe_customer_id, :admin, :uid, :provider
  include Clearance::User
  has_many :transactions
  has_many :posts
  has_many :groups_as_member, :through => :memberships, :source => :group, :class_name => "Group", :foreign_key => :user_id
  has_many :groups_as_owner, :class_name => "Group"
  has_many :memberships, :dependent => :destroy, :foreign_key => :member_id
  #has_many :images
  has_many :followships, :foreign_key => :follower_id
  has_many :followed_tags, through: :followships, source: :followed, :class_name => "Tag"
  
  
  validates_uniqueness_of :email
  validates :email, :email_format => true, :presence => true
  
  has_many :authentications, :dependent => :destroy
  
  def self.create_with_auth_and_hash(authentication,auth_hash)
    create! do |u|
      u.first_name = auth_hash["info"]["first_name"]
      u.last_name = auth_hash["info"]["last_name"]
      u.friendly_name = auth_hash["info"]["name"]
      u.email = auth_hash["extra"]["raw_info"]["email"]
      u.authentications<<(authentication)
    end
  end
 
  
  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end
  
  
  def password_optional?
    true
  end
  
  
  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
  
  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |user|
        csv << user.attributes.values_at(*column_names)
      end
    end
  end
  #attr_accessor :stripe_card_token
  
  # attr_accessor :stripe_card_token
  
  # def save_as_customer(email, stripe_card_token)
  # def save_as_customer
  #   if valid?
  #     customer = Stripe::Customer.create( :description => self.email, :card => stripe_card_token)
  #     self.stripe_customer_id = customer.id
  #     save!
  #   end
  # rescue Stripe::InvalidRequestError => e
  #   logger.error "Stripe error while creating customer: #{e.message}"
  #   errors.add :base, "There was a problem with your credit card."
  #   false
  # end

  def charge_as_customer(amount)
    customer_id = Stripe::Customer.retrieve(self.stripe_customer_id)
    Stripe::Charge.create(:amount => amount, :currency => "usd", :customer => customer_id)
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while charging card: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false   
  end
  
  def update_payment_details(email, token)
    customer = Stripe::Customer.create( :description => email, :card => token)
    self.update_attributes(:stripe_customer_id => customer.id)
  end
  
  
  
  
  
  
  
  
  
  # def save_customer
  #     p stripe_card_token
  #     if valid?
  #       customer = Stripe::Customer.create( :description => email, :card => stripe_card_token )
  #     end
  #   rescue Stripe::InvalidRequestError => e
  #     logger.error "Stripe error while creating customer: #{e.message}"
  #     errors.add :base, "There was a problem with your credit card."
  #     false
  #   end
  # 
  #   def save_customer_with_payment(tier,price)
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
  #       Stripe::Charge.create(:amount => amount, :currency => "usd", :card => customer)
  #     end
  #   rescue Stripe::InvalidRequestError => e
  #     logger.error "Stripe error with payment: #{e.message}"
  #     errors.add :base, "There was a problem with your credit card."
  #     false
  #   end
  #   
  def payment(amount)
    customer = Stripe::Customer.retrieve(self.stripe_customer_id)     
    Stripe::Charge.create(:amount => amount, :currency => "usd", :customer => customer)
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while charging card: #{e.message}"
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
    groups_as_member = self.groups_as_member
    groups = groups_as_owner + groups_as_member
    # if groups.empty?
    #   return Group.first
    # else
    #   return groups
    # end
  end
  
  def following?(tag)
    followships.find_by_followed_id(tag.id)
  end

  def follow!(tag)
    followships.create!(followed_id: tag.id)
  end

  def unfollow!(tag)
    followships.find_by_followed_id(tag.id).destroy
  end
  
  def join!(group)
    if group.members.count > 500
      memberships.create!(group_id: group.id, email_setting_id: 2)
    else
      memberships.create!(group_id: group.id, email_setting_id: 1)
    end
  end
  
  def leave!(group)
    memberships.find_by_followed_id(tag.id).destroy
  end
  

  
end
