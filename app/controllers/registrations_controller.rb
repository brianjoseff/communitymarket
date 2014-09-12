class RegistrationsController < Devise::RegistrationsController



  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?
    end
    # Override Devise to use update_attributes instead of update_with_password.
    # This is the only change we make.
    if resource.update_attributes(params[:user])
      set_flash_message :notice, :updated
      # Line below required if using Devise >= 1.2.0
      sign_in :user, resource, :bypass => true
      redirect_to after_update_path_for(resource)
    else
      clean_up_passwords(resource)
      render_with_scope :edit
    end
  end

  protected

   def after_sign_up_path_for(resource)
     #user_url(current_user)
     #sign_up_and_redirect current_user, :event => :authentication
     request.env['omniauth.origin'] || stored_location_for(resource) || root_path
   end


end