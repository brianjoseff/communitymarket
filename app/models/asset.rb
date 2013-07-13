class Asset < ActiveRecord::Base
  #Assets are the polymorphic object that holds multiple images for Posts, Users, Groups, etc..
  attr_accessible :imageable_id, :image
  #settings for Paperclip gem that attaches images
  has_attached_file :image, :styles => { :normal => "100%",:small => "100 x100>",:medium => "200x200>", :thumb => "50x50>" },
                            :storage => :s3, 
                            :s3_credentials => "#{Rails.root}/config/s3.yml", 
                            :path => "/:attachment/:id/:style/:filename"
end
