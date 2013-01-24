class Post < ActiveRecord::Base
  attr_accessible :borrow, :description, :post_category_id, :premium, :tier, :title, :user_id
  has_many :assets, :as => :imageable, :dependent => :destroy
  belongs_to :post_category
  belongs_to :user
  has_many :assignments, :dependent => :destroy
  has_many :groups, :through => :assignments
end
