class Tag < ActiveRecord::Base
  attr_accessible :name, :description, :follower_ids
  has_many :taggings
  has_many :posts, :through=> :taggings
  has_many :followships, :foreign_key => :followed_id
  has_many :followers, through: :followships, source: :follower, :foreign_key => :follower_id
  
  
  def self.tokens(query)
    tags = where("name like ?","%#{query}%")
    if tags.empty?
      [{:id=> "<<<#{query}>>>", :name=> "New: \"#{query}\"", :description=>""}]
    else
      tags
    end
  end
  
  def self.ids_from_tokens(tokens)
    tokens.gsub!(/<<<(.+?)>>>/) { create!(:name => $1).id }
    tokens.split(',')
  end
end
