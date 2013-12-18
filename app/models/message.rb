class Message < ActiveRecord::Base
  attr_accessible :content, :post_id, :recipient, :sender, :subject
  validate :subject, :content, :recipient, :sender, :presence => true
end
