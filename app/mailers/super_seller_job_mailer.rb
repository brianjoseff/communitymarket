class SuperSellerJobMailer < ActionMailer::Base
  default from: "brian@peopleandstuff.com"

  def contact_job_owner(owner, seller, msg, super_seller_job)
    @owner = owner
    @seller = seller
    @msg = msg
    @super_seller_job = super_seller_job
    mail( :to => @owner.email,
          :subject => "A SuperSeller wants to sell your stuff!" )
  end

  def share_job_info_with_seller(owner, seller, job)
    @owner = owner
    @seller = seller
    @job = job
    mail( :to => @seller.email,
          :subject => "Please pick up items from #{@owner.name}" )
  end

end
