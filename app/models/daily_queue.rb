class DailyQueue < ActiveRecord::Base
  # these are the emails that are queued for users that wish
  # to receive daily updates for groups they are a part of
  # rather than per-post updates
  
  attr_accessible :post_id, :user_id, :sender_id, :group_id
  
  
  def self.send_email
    #add time range restraint as well
    DailyQueue.all.each do |item|
      sender = User.find(item.user_id)
      recipient = User.find(item.sender_id)
      post = Post.find(item.post_id)
      group = Group.find(item.group_id)
      DailyQueueMailer.notify(sender, post, recipient, group).deliver
      
      # if ActionMailer::Base.deliveries.last.to != recipient.email
      #   return
      # end
      item.destroy
    end
  end
end
