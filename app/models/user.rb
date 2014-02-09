class User < ActiveRecord::Base
  
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :validatable, :trackable

  # Setup accessible (or protected) attributes for your model
  # attr_accessible :email, :password
  attr_accessible :email, :name, :password, :password_confirmation, :remember_me, :stripe_customer_id, :admin, :provider, :uid, :oauth_token, :oauth_expires_at
  #include Clearance::User
  has_many :transactions
  has_many :posts
  has_many :groups_as_member, :through => :memberships, :source => :group, :class_name => "Group", :foreign_key => :user_id
  has_many :groups_as_owner, :class_name => "Group"
  has_many :memberships, :dependent => :destroy, :foreign_key => :member_id
  #has_many :images
  has_many :followships, :foreign_key => :follower_id
  has_many :followed_tags, through: :followships, source: :followed, :class_name => "Tag"
  
  has_merit
  
  validates_uniqueness_of :email
  validates :email, :email_format => true, :presence => true
  
  def stripe_parameters
    {
      'stripe_user[business_type]' => 'sole_prop',
      'stripe_user[currency]' => 'usd'
    }
  end
  

  def apply_omniauth(omniauth)
    self.secret_key = omniauth['credentials']['token']
    self.public_key = omniauth['info']['stripe_publishable_key']
    self.uid = omniauth['uid']
  end
  
  def facebook
    @facebook ||= Koala::Facebook::API.new(oauth_token)
  end
  
  
  def update_profile_to_facebook(auth)
      
      self.update_attributes(name:auth.raw_info.name,
                           provider:auth.provider,
                           uid:auth.uid,
                           email:auth.info.email,
                           password:Devise.friendly_token[0,20],
                           oauth_token: auth.credentials.token,
                           oauth_expires_at: Time.at(auth.credentials.expires_at)
                           )
      
  end
  def update_external_account(auth)
     user = User.where(:provider => auth.provider, :uid => auth.uid).first

     if user && user != self
       return false
     end

     self.provider = auth.provider
     self.uid = auth.uid
     self.oauth_token = auth.credentials.token
     self.oauth_expires_at = Time.at(auth.credentials.expires_at)
     self.save!
   end
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    # do you want to edit your profile to make it facebook enabled?
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(name:auth.extra.raw_info.name,
                           provider:auth.provider,
                           uid:auth.uid,
                           email:auth.info.email,
                           password:Devise.friendly_token[0,20],
                           oauth_token: auth.credentials.token,
                           oauth_expires_at: Time.at(auth.credentials.expires_at)
                           )
    end
    user
  end
  # def self.find_or_create_from_auth_hash(auth_hash)
  #         find_by_auth_hash(auth_hash) || create_from_auth_hash(auth_hash)
  # end
  # 
  # def self.find_by_auth_hash(auth_hash)
  #         where(
  #                 provider: auth_hash.provider,
  #                 uid: auth_hash.uid
  #                 ).first
  # end
  # 
  # def self.create_from_auth_hash(auth_hash)
  #         create(
  #                 provider: auth_hash.provider,
  #                 uid: auth_hash.uid,
  #                 email: auth_hash.info.email,
  #                 name: auth_hash.info.name,
  #                 oauth_token: auth_hash.credentials.token,
  #                 oauth_expires_at: Time.at(auth_hash.credentials.expires_at)
  #                 )
  # end
  
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
  def check_if_signed_in
    if !signed_in?
      return User.new
    else
      return current_user
    end
  end
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
    if group.members.count > 100
      memberships.create!(group_id: group.id, email_setting_id: 2)
    else
      memberships.create!(group_id: group.id, email_setting_id: 1)
    end
  end
  
  def leave!(group)
    memberships.find_by_followed_id(tag.id).destroy
  end
  

  
end
