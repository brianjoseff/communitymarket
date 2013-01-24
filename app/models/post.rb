class Post < ActiveRecord::Base
  attr_accessible :borrow, :description, :post_category_id, :premium, :tier, :title, :user_id
end
