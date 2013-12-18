class ContactsController < ApplicationController
  def new
    @content = params[:content]
    @user = current_user
    ContactMailer.vox(@user, @content).deliver
    redirect_to about_path, :notice => "Thanks for the message"
  end
end