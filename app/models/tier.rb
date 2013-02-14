class Tier < ActiveRecord::Base
  attr_accessible :name, :tier_id
  has_many :posts
end
