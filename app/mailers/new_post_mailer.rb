class NewPostMailer < ActionMailer::Base
  default :from => "group-notifications@peopleandstuff.com"
  def notify(creator, post, recipient, group)
    @creator = creator
    @group = group
    @recipient = recipient
    @post = post
    # @category = category
    @post_name = post.title
    @post_desc  = post.description
    #attachments[""]
    mail(:to => recipient.email, :subject => "#{@post.post_category.name} | #{@post_name}", :reply_to => creator.email)
  end
  
end
