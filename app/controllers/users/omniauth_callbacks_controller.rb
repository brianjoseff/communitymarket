class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)
  
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url, notice: "Oops, something went wrong"
    end
  end
  
  # def facebook
  #   @user = User.find_or_create_from_auth_hash auth_hash
  #   if @user.persisted?
  #     sign_in_and_redirect @user
  #   else
  #     session["devise.user_attributes"] = @user.attributes
  #     redirect_to new_user_registration_url, notice: "Oops, something went wrong"
  #   end
  # end
  # 
  # private
  # 
  # def auth_hash
  #   request.env['omniauth.auth']
  # end
end