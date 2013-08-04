class Group < ActiveRecord::Base
  attr_accessible :description, :group_category, :name,  :group_category_id, :user_id, :member_ids
  has_many :assets, :as => :imageable, :dependent => :destroy


  
  has_many :memberships
  has_many :members,    :through => :memberships, :source => :member, :foreign_key => :member_id
  belongs_to :owner,    :class_name => "User", :foreign_key => :user_id
  belongs_to :group_category
  has_many :assignments
  has_many :posts,      :through => :assignments
  
  validates :name, :presence => true
end
