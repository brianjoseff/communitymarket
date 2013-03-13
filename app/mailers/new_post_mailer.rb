class NewPostMailer < ActionMailer::Base
  default :from => "brianjoseff123@peopleandstuff.com"
  def notify(creator, post, category, recipient, group)
    @creator = creator
    @group = group
    @recipient = recipient
    @post = post
    @category = category
    @post_name = post.title
    @post_desc  = post.description
    #attachments[""]
    mail(:to => recipient.email, :subject => "#{@category} | #{@post_name}", :reply_to => creator.email)
  end
end
