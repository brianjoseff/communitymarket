class PostCategory < ActiveRecord::Base
  attr_accessible :name, :post_category_id
  has_many :posts
end
