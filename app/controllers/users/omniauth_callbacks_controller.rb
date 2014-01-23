class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    # If a user is signed in then he is trying to link a new account
    if user_signed_in?
      
        auth = request.env["omniauth.auth"]
        if current_user && current_user.persisted? && current_user.update_external_account(auth)
          flash[:success] = "Your facebook account has been linked to this user account successfully."
          @post = current_user.posts.last
          if @post.post_to_facebook?
            @post.after_sign_in_post_to_facebook
          end
            
        else
          flash[:error] = "The Facebook account has been linked with another user."
        end
        redirect_to edit_user_registration_path
        # auth =request.env["omniauth.auth"]
        # @user = User.find_by_email(params[:email]).update_attributes(name:auth.raw_info.name,
        #                      provider:auth.provider,
        #                      uid:auth.uid,
        #                      email:auth.info.email,
        #                      password:Devise.friendly_token[0,20],
        #                      oauth_token: auth.credentials.token,
        #                      oauth_expires_at: Time.at(auth.credentials.expires_at)
        #                      )
      # if @user == true # This was a linking operation so send back the user to the account edit page  
      #       flash[:success] = I18n.t "controllers.omniauth_callbacks.process_callback.success.link_account", 
      #                               :provider => registration_hash[:provider].capitalize, 
      #                               :account => registration_hash[:email]
      #     else
      #       flash[:error] = I18n.t "controllers.omniauth_callbacks.process_callback.error.link_account", 
      #                              :provider => registration_hash[:provider].capitalize, 
      #                              :account => registration_hash[:email],
      #                              :errors =>authentication.errors
      #     end  
      #     redirect_to edit_user_account_path(current_user)
    else
      @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)
  
      if @user.persisted?
        sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
        set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
      else
        session["devise.facebook_data"] = request.env["omniauth.auth"]
        redirect_to new_user_registration_url, notice: "Oops, something went wrong"
      end
    end
  end
  
  def stripe_connect
    # attempt 1
    if !current_user.stripe_connect
      callback = OmniauthCallbackCreator.new({user: current_user, \
        params: request.env["omniauth.auth"]})
      if callback.save
        redirect_to root_path, notice: 'Thank you! You have successfully linked your account with stripe!
        Now you can sell your lesson plans with ease!'
      else
        redirect_to root_path, alert: 'There was an error when linking your account with stripe.
        Please make sure your credentials are correct and try again in a few minutes.'
      end
    else
        redirect_to root_path, notice: 'You have already linked your account with stripe, thank you!'
    end
    
    # attempt 2
    omniauth = request.env["omniauth.auth"]
    current_user.apply_omniauth(omniauth)
    current_user.save!
    redirect_to new_item_path
  end
  # def facebook_update_and_post
  #   @user = User.update_profile_to_facebook(request.env["omniauth.auth"], current_user)
  #   if @user.persisted?
  #     redirect_to current_user, notice: "Yeehaw"
  #     #set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
  #   else
  #     session["devise.facebook_data"] = request.env["omniauth.auth"]
  #     redirect_to current_user, notice: "Oops, something went wrong"
  #   end
  # end

  
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