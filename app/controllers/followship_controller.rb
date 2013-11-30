class FollowshipsController < ApplicationController
  before_filter :redirect_to_signup
  def index
  end

  def update
  end
  
  def destroy
    @followship = Followship.find(params[:id])
    if @followship.destroy
      redirect_to @followship.group
      flash[:success] = "unfollowed tag"
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