class Tag < ActiveRecord::Base
  attr_accessible :name, :description
  has_many :taggings
  has_many :posts, :through=> :taggings
  
  
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
