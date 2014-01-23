class MessageMailer < ActionMailer::Base
  default from: "from@example.com"
  
  def send_message(post, sender, recipient, subject, content)
    @subject = "[people and stuff] " +  subject
    @content = content
    @sender = sender
    @recipient = recipient
    @post = post
    mail(:to => @recipient, :from => @sender, :subject => @subject, :reply_to => @sender)
  end
end
