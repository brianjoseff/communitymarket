class DailyQueue < ActiveRecord::Base
  # these are the emails that are queued for users that wish
  # to receive daily updates for groups they are a part of
  # rather than per-post updates
  
  attr_accessible :post_id, :user_id, :sender_id, :group_id
  
  
  def self.send_email
    #add time range restraint as well
    
    #should group them by :user_id because that is a
    #user's queue of items they expect to receive a daily update about
    
    #user group_by
    #http://stackoverflow.com/questions/3817189/one-liner-to-chunk-ruby-objects-into-sub-arrays-based-on-date-timeframe
    
    array_of_users_queued_posts = DailyQueue.all.group_by{|p| p.user_id}.values
    
    array_of_users_queued_posts.each do |array|
      users_posts = array
      recipient = User.find(array.first.sender_id)
      DailyQueueMailer.notify(recipient, users_posts).deliver
    end
      
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
