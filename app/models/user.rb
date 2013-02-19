class User < ActiveRecord::Base
  attr_accessible :email, :name, :password
  include Clearance::User
  has_many :posts
  has_many :groups_as_member, :through => :memberships, :source => :group, :class_name => "Group", :foreign_key => :user_id
  has_many :groups_as_owner, :class_name => "Group"
  
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
