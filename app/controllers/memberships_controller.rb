class MembershipsController < ApplicationController
  before_filter :redirect_to_signup
  
  
  respond_to :html, :js
  
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
    @group = Group.find(params[:id])
    if @membership.destroy
      respond_with @group
      flash[:success] = "left group"
    end
  end
  
  
  def create
    @group = Group.find(params[:membership][:group_id])
    current_user.join!(@group)
    @your_groups = current_user.group_feed
    respond_with @group
  end
  
  
  
  # def destroy
  #   @membership = Membership.find(params[:id])
  #   if @membership.destroy
  #     redirect_to @membership.group
  #     flash[:success] = "You left #{@membership.group.name}"
  #   end
  # end
  
  private

    def redirect_to_signup
      @group = Group.find(params[:membership][:group_id])
      unless signed_in?
        store_location
        store_group(@group)
        redirect_to new_user_path, notice: "Please sign up or in."
      end
    end
    
    def store_location
      # session[:return_to] = request.url
      session[:return_to] = root_path
      #setting to root here because it redirects to sign up when the user tries to access /followships
      
    end
    def store_group(group)
      session[:joined_group] = group.to_param
    end
end