class InvitesController < ApplicationController
  def new
    @emails = params[:content].scan(/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i)
    @users_from_address = User.find_by_id(params[:from]).email
    @user = current_user
    @group = Group.find(params[:group_id])
    @emails.each do |email|  
      InviteMailer.invite(@user, email, @users_from_address, @group).deliver
    end
    redirect_to current_user, :notice => "Thanks for inviting people. Sharing is caring."
  end
end