class PagesController < ApplicationController
  # skip_before_filter :require_login
  # skip_before_filter :authorize
  def index
    @post = Post.new
    @transaction = Transaction.new
<<<<<<< HEAD
    if !signed_in?
      @user = User.new
      
    else
=======

    if signed_in? && current_user.post_feed.is_a?(Array)
>>>>>>> branch
      @user = current_user
      @posts = Post.paginate(:page => params[:page], :per_page => 15, :order => "created_at DESC")
      #@posts = current_user.post_feed.paginate(:page => params[:page], :per_page => 15, :order => "created_at DESC")
      @groups = current_user.group_feed.paginate(:page => params[:page], :per_page => 15, :order => "created_at DESC")
      @random_groups = Group.paginate(:page => params[:page], :per_page => 15, :order => "RANDOM()")
    else
      @user = User.new
      @posts = Post.paginate(:page => params[:page], :per_page => 15, :order => "created_at DESC")
      @groups = Group.paginate(:page => params[:page], :per_page => 15, :order => "created_at DESC")
    end
  end
  
  def about
  end
  
end

