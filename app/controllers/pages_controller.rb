class PagesController < ApplicationController
  # skip_before_filter :require_login
  # skip_before_filter :authorize
  def index
    @post = Post.new
    @transaction = Transaction.new
    if !signed_in?
      @user = User.new
    else
      @user = current_user
    end
    if signed_in? && current_user.post_feed.empty? == false
      @posts = current_user.post_feed.paginate(:page => params[:page], :per_page => 15, :order => "created_at DESC")
      @groups = current_user.group_feed.paginate(:page => params[:page], :per_page => 15, :order => "created_at DESC")
    else
      @posts = Post.paginate(:page => params[:page], :per_page => 15, :order => "created_at DESC")
      @groups = Group.paginate(:page => params[:page], :per_page => 15, :order => "created_at DESC")
    end
  end
  
  def about
  end
  
end

