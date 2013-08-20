class MembershipsController < ApplicationController
  before_filter :redirect_to_signup
  def index
  end

  def update

  end
  def update_individual
    @user = current_user
    #@membership = Membership.find(params[:id])
    @email_settings = EmailSetting.all
    Membership.update(params[:memberships].keys, params[:memberships].values)
    flash[:notice] = "Emails Settings succesfully updated"
    redirect_to @user
    # respond_to do |format|
    #       if @membership.update_attributes(params[:membership])
    #         format.html { redirect_to @user, notice: 'Email setting was successfully updated.' }
    #         format.json { head :no_content }
    #       else
    #         format.html { render action: "edit" }
    #         format.json { render json: @membership.errors, status: :unprocessable_entity }
    #       end
    #     end
  end
  
  def destroy
    @membership = Membership.find(params[:id])
    if @membership.destroy
      redirect_to @membership.group
      flash[:success] = "member removed"
    end
  end
  
  private
    def redirect_to_signup
      unless signed_in?
        store_location
        redirect_to signup_path, notice: "Please sign up or in."
      end
    end
end