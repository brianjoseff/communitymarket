class DailyQueueMailer < ActionMailer::Base
  default :from => "new-stuff@peopleandstuff.com"
  # def notify(creator, post, recipient, group)
  def notify(recipient, users_posts)
    

    @recipient = recipient
    @posts = users_posts
    # @post = post
    # @creator = creator
    # @group = group
    # @post_name = post.title
    # @post_desc  = post.description
    #attachments[""]
    mail(:to => recipient.email, :subject => "New Stuff Today")
  end
end
