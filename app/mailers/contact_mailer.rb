class ContactMailer < ActionMailer::Base
  default :from => "user-input@peopleandstuff.com"
  
  def vox(user, content, email)
    @content = content
    @user = user
    mail(:to => ENV["GMAIL_USERNAME"], :subject => "User Input", :reply_to => @user ? @user.email : email)
  end
end
