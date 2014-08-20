class Dress < ActiveRecord::Base
  attr_accessible :comments_on_fit, :rental, :retail, :size, :title, :assets_attributes
  
  has_many :assets, :as => :imageable, :dependent => :destroy
  
  accepts_nested_attributes_for :assets
end
