class Followship < ActiveRecord::Base
  # join table for users and tags
  # users can follow a tag and will get emails when posts with that tag are created
  
  attr_accessible :followed_id, :follower_id
  
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "Tag"
  
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
