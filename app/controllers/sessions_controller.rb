class SessionsController < ApplicationController
  # skip_before_filter :require_login
  # skip_before_filter :authorize
  
  #sessions implemented using Clearance gem
  
  def new
      
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
        current_user.follow!(@tag)
        session.delete(:followed_tag)
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
