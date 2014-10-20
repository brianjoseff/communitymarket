class SuperSellerJobMailer < ActionMailer::Base
  default from: "brian@peopleandstuff.com"

  def contact_job_owner(user)
    @user = user
    mail(:to => user.email, :subject => "A SuperSeller wants to sell your stuff!")
  end



end
