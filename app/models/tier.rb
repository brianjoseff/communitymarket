class Tier < ActiveRecord::Base
  attr_accessible :name, :tier_id, :price
  has_many :posts
end
