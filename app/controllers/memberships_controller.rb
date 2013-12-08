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
    @group = Group.find(params[:membership][:group_id])
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
  
  def join
    @group = Group.find(params[:membership][:group_id])
    current_user.join!(@group)
    @your_groups = current_user.group_feed
    respond_with @group
    
    # @group = Group.find(params[:group_id])
    # params[:group][:member_ids] = (params[:group][:member_ids] << @group.member_ids).flatten
    # 
    # respond_to do |format|
    #   if params[:password] == @group.password && @group.update_attributes(params[:group])
    #     flash[:success] = "Successfully joined #{@group.name}"
    #     format.html { redirect_to root_path }
    #     format.js
    #     # format.html { redirect_to @group, notice: 'Group was successfully updated.' }
    #     #         format.json { head :no_content }
    #   else
    #     if params[:password] != @group.password
    #       flash.now[:wrong_password] = "Wrong Password"
    #     end
    #     format.html { render action: "show"}
    #     format.json { render json: @group.errors, status: :unprocessable_entity }
    #   end
    # end
    
    
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
      
      unless signed_in?
        if params[:membership]
          @group = Group.find(params[:membership][:group_id])
        end
        store_location
        store_group(@group)
        redirect_to new_user_registration_path, notice: "Please sign up or in."
      end
    end
    
    def store_location
      # session[:return_to] = request.url
      session[:user_return_to] = root_path
      #setting to root here because it redirects to sign up when the user tries to access /followships
      
    end
    def store_group(group)
      session[:joined_group] = group.to_param
    end
end