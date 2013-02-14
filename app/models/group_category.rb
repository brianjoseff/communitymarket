class GroupCategory < ActiveRecord::Base
  attr_accessible :name, :group_category_id
  has_many :groups
end
