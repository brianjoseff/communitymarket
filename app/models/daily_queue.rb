class DailyQueue < ActiveRecord::Base
  attr_accessible :post_id, :user_id, :sender_id, :group_id
  
  
  def self.send_email
    #add time range restraint as well
    DailyQueue.all.each do |item|
      sender = User.find(item.user_id)
      recipient = User.find(item.sender_id)
      post = Post.find(item.post_id)
      group = Group.find(item.group_id)
      DailyQueueMailer.notify(sender, post, recipient, group).deliver
      rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
        return
      item.destroy
    end
  end
end
