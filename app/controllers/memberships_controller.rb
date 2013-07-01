class MembershipsController < ApplicationController
  before_filter :redirect_to_signup
  def index
  end

  def update
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