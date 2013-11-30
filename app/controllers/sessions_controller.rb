class SessionsController < ApplicationController
  # skip_before_filter :require_login
  # skip_before_filter :authorize
  
  #sessions implemented using Clearance gem
  
  def new
      
  end
  def create_facebook
    # user = User.from_omniauth(env["omniauth.auth"])
    # session[:user_id] = user.id
    # redirect_to root_url
      auth_hash = request.env["omniauth.auth"]

      authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]) || Authentication.create_with_omniauth(auth_hash)
      if authentication.user
        user = authentication.user 
        authentication.update_token(auth_hash)
        @next = root_url
        @notice = "Signed in!"
      else
        user = User.create_with_auth_and_hash(authentication,auth_hash)
        @next = edit_user_path(user)   
        @notice = "User created - confirm or edit details..."
      end
      sign_in(user)
      redirect_to @next, :notice => @notice
    end
  end
  def create
    @user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if @user.nil?
      #create an error message and rerender signin form
      flash.now[:error] = "Invalid email/password"
      @title = "Sign in"
      render 'new'
    else
      #sign the user in and redirect to the user's show page.
      sign_in @user
      redirect_back_or @user, nil
    end
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end
  
  private
    def redirect_back_or(default, notice)
      flash[:notice] = notice
      if session[:followed_tag]
        @tag = Tag.find(session[:followed_tag])
        unless current_user.followed_tags.include?(@group)
          current_user.follow!(@tag)
        end
        session.delete(:followed_tag)
      end
      if session[:joined_group]
        @group = Group.find(session[:joined_group])
        unless current_user.groups_as_member.include?(@group)
          current_user.join!(@group)
        end
        session.delete(:joined_group)
      end
      if session[:return_to]
        redirect_to session[:return_to]
        session.delete(:return_to)
      else
        redirect_to default
      end
      
    end
  
    def store_location
      session[:return_to] = request.fullpath
    end
  end
end
