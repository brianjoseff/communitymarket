class SuperSellerJobsController < ApplicationController
  before_filter :authorize_user!
  before_filter :confirm_user_as_author, :only => [:edit, :destroy]

  def index
    redirect_to root_path unless current_user.super_seller
    @super_seller_jobs = SuperSellerJob.all
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
    @super_seller_job.destroy
    respond_to do |format|
      format.html { redirect_to super_seller_jobs_url, notice: 'Super Seller Job was successfully destroyed.' }
    end
  end

  private

  def confirm_user_as_author
    super_seller_job = SuperSellerJob.find(params[:id])
    redirect_to root_path, notice: "You can't edit someone else's post!" unless current_user.id == super_seller_job.owner_id
  end

end
