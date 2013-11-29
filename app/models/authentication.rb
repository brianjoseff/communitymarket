class Authentication < ActiveRecord::Base
  attr_accessible :provider, :token, :uid, :user_id
  belongs_to :user
  
  def self.create_with_omniauth(auth_hash)
      create! do |auth|
        auth.provider = auth_hash["provider"]
        auth.uid = auth_hash["uid"]
        auth.token = auth_hash["credentials"]["token"]
      end
    end

    def update_token(auth_hash)
      self.token = auth_hash["credentials"]["token"]
      self.save
    end
    
end
