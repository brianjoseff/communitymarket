class SuperSellerJobsController < ApplicationController
  before_filter :authorize_user!, :except => :accept_super_seller  # allow POST requests from emails
  before_filter :confirm_user_as_author, :only => [:edit, :destroy]

  def index
    redirect_to root_path unless current_user.super_seller
    @super_seller_jobs = SuperSellerJob.order('created_at DESC')
  end

  def show
    @super_seller_job = SuperSellerJob.find(params[:id])
  end

  def new
    @super_seller_job = SuperSellerJob.new
  end

  def edit
    @super_seller_job = SuperSellerJob.find(params[:id])
  end

  def create
    # Strip phone number from form data
    phone = params[:super_seller_job].delete(:phone)

    # Update current user's phone # if different
    current_user.update_attributes(phone: phone) if current_user.phone != phone

    @super_seller_job = SuperSellerJob.new(params[:super_seller_job])
    respond_to do |format|
      if @super_seller_job.save
        format.html { redirect_to user_path(current_user), notice: 'Your Super Seller job was successfully added to our queue. A SuperSeller will be in contact with you shortly!' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    phone = params[:super_seller_job].delete(:phone)
    current_user.update_attributes(phone: phone) if current_user.phone != phone

    @super_seller_job = SuperSellerJob.find(params[:id])

    respond_to do |format|
      if @super_seller_job.update_attributes(params[:super_seller_job])
        format.html { redirect_to user_path(current_user), notice: 'Super Seller Job was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @super_seller_job = SuperSellerJob.find(params[:id])
    @super_seller_job.destroy
    respond_to do |format|
      format.html { redirect_to user_path(current_user), notice: 'Super Seller Job was successfully destroyed.' }
    end
  end

  def notify_owner
    super_seller_job = SuperSellerJob.find(params[:job_id])
    msg = params[:sseller_msg]
    owner = User.find(super_seller_job.owner_id)
    SuperSellerJobMailer.contact_job_owner(owner, current_user, msg, super_seller_job).deliver
    redirect_to super_seller_jobs_path, notice: 'Your message was successfully sent to the job owner!'
  end


  def accept_super_seller
    # ex. params {"oid"=>"66", "sid"=>"77", "controller"=>"super_seller_jobs", "jid"=>"2"}
    job    = SuperSellerJob.find(params[:jid])
    seller = User.find(params[:sid].to_i)
    owner  = User.find(params[:oid].to_i)

    # Make sure job params from email match job params in database
    if job.owner_id != owner.id
      redirect_to root_path, notice: "Sorry that job doesn't exist."
    end

    job.update_attributes(super_seller_id: seller.id)

    # Send job info to SuperSeller
    SuperSellerJobMailer.share_job_info_with_seller(owner, seller, job).deliver

    redirect_to root_path, notice: "Your Super Seller Job info was successfully shared with #{seller.name}.\n\nOnce the SuperSeller picks up your items, please DEACTIVATE the job in your dashboard to remove it from being listed."
  end

  private

  def confirm_user_as_author
    super_seller_job = SuperSellerJob.find(params[:id])
    redirect_to root_path, notice: "You can't edit someone else's post!" unless current_user.id == super_seller_job.owner_id
  end

end
