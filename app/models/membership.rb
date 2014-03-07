class Membership < ActiveRecord::Base
  attr_accessible :group_id, :member_id, :email_setting_id, :user_id
  belongs_to :member, :class_name => "User"
  belongs_to :group
  validates_uniqueness_of :member_id, :scope => :group_id
end
