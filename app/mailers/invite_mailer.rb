class InviteMailer < ActionMailer::Base
  default :from => "no-reply@peopleandstuff.com"
  
  def invite(name, to_address, from_address, group)
    @group = group
    mail(:to => to_address, :subject => "People and Stuff | join this group, from #{name}", :reply_to => from_address)
  end
end
