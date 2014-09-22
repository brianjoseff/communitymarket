class SuperSellerJobsController < ApplicationController

  def index
    @super_seller_jobs = SuperSellerJob.all
  end

  def show
  end

  def new
    @super_seller_job = SuperSellerJob.new
    @user = current_user
  end

  def edit
  end

  def create
    @super_seller_job = SuperSellerJob.new(super_seller_job_params.merge(owner_id: current_user.id))
    respond_to do |format|
      if @super_seller_job.save
        format.html { redirect_to super_seller_jobs_path, notice: 'Your SuperSeller will be in contact with you shortly!' }
        format.json { render :show, status: :created, location: @super_seller_job }
      else
        format.html { render :new }
        format.json { render json: @super_seller_job.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @super_seller_job.update(super_seller_job_params)
        format.html { redirect_to @super_seller_job, notice: 'Super Seller Job was successfully updated.' }
        format.json { render :show, status: :ok, location: @super_seller_job }
      else
        format.html { render :edit }
        format.json { render json: @super_seller_job.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @super_seller_job.destroy
    respond_to do |format|
      format.html { redirect_to super_seller_jobs_url, notice: 'Super Seller Job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_super_seller_job
      @super_seller_job = SuperSellerJob.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.

    # BUGBUG: 'TypeError Exception: no implicit conversion of Symbol into String'
    def super_seller_job_params
      params.require(:super_seller_job).permit(:owner_id, :super_seller_id, :estimated_value, :sell_options, :pickup_location, :notes)
    end


end
