class InviteMailer < ActionMailer::Base
  default :from => "no-reply@peopleandstuff.com"
  
  def invite(user, to_address, from_address, group)
    @group = group
    if @group.private?
      @password = group.password
    end
    mail(:to => to_address, :subject => "People and Stuff | join this group, from #{user.name.nil? ? user.email : user.name}", :reply_to => from_address)
  end
end
