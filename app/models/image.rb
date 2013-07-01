class Image < ActiveRecord::Base
  attr_accessible :user_id, :image, :assets_attributes
  has_many :assets, :as => :imageable, :dependent => :destroy
  belongs_to :user
  accepts_nested_attributes_for :assets
end
