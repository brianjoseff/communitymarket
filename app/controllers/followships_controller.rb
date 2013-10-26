class FollowshipsController < ApplicationController
  before_filter :redirect_to_signup, :only => [:create]
  
  respond_to :html, :js
  def index
  end

  def update
  end
  
  def destroy
    @followship = Followship.find(params[:id])
    @tag = Tag.find(params[:followship][:followed_id])
    if @followship.destroy
      respond_with @tag
      # flash[:success] = "unfollowed tag (destroy method)"
    end
  end
  
  
  def create
    @tag = Tag.find(params[:followship][:followed_id])
    current_user.follow!(@tag)
    respond_with @tag
  end

  # def destroy
  #   @tag = Tag.find(params[:followship][:followed_id])
  #   @followship = Followship.find(params[:id]).followed
  #   current_user.unfollow!(@user)
  #   respond_with @user
  # end
  # 
  def leave
    @followship = Followship.find(params[:id])
    @tag = Tag.find(params[:followship][:followed_id])
    if @followship.destroy
      respond_with @tag
      # flash[:success] = "unfollowed tag"
    end
  end
  def follow
    @tag = Tag.find(params[:followship][:followed_id])
    current_user.follow!(@tag)
    # @your_tags = current_user.group_feed
    respond_with @tag
  end
  
  private
    def redirect_to_signup
      @tag = Tag.find(params[:followship][:followed_id])
      unless signed_in?
        store_location
        store_tag(@tag)
        redirect_to new_user_path, notice: "Please sign up or in."
      end
    end
    
    def store_location
      # session[:return_to] = request.url
      session[:return_to] = root_path
      #setting to root here because it redirects to sign up when the user tries to access /followships
      
    end
    def store_tag(tag)
      session[:followed_tag] = tag.to_param
    end
end