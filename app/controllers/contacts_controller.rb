class ContactsController < ApplicationController
  # this is for the "Contact Me" mailer form on the About page
  def new
    @content = params[:content]
    @email = params[:email]
    @user = current_user
    ContactMailer.vox(@user, @content, @email).deliver
    redirect_to about_path, :notice => "Thanks for the message"
  end
end