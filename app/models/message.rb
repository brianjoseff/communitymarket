class Message < ActiveRecord::Base
  # the way potential buyers can contact sellers
  
  attr_accessible :content, :post_id, :recipient, :sender, :subject
  validate :subject, :content, :recipient, :sender, :presence => true
end
