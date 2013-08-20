class WeeklyQueue < ActiveRecord::Base
  attr_accessible :post_id, :user_id, :sender_id, :group_id
end
