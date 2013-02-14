class User < ActiveRecord::Base
  attr_accessible :email, :name, :password
  include Clearance::User
  has_many :posts
  has_many :groups_as_member, :through => :memberships, :source => :group, :class_name => "Group", :foreign_key => :user_id
  has_many :groups_as_owner, :class_name => "Group"
  
  
end
