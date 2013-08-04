class PagesController < ApplicationController
  # skip_before_filter :require_login
  # skip_before_filter :authorize
  def index
    @post = Post.new
    @transaction = Transaction.new
    @sort_posts = Post.search()
    @sorted_posts = @sort_posts.result
    if signed_in? && current_user.post_feed.is_a?(Array)
      @user = current_user
      @posts = Post.paginate(:page => params[:page], :per_page => 15, :order => "created_at DESC")
      #@posts = current_user.post_feed.paginate(:page => params[:page], :per_page => 15, :order => "created_at DESC")
      @groups = current_user.group_feed.paginate(:page => params[:page], :per_page => 15, :order => "created_at DESC")
      
      @random_groups = Group.all - @user.groups_as_member
      @followed_tags = @user.followed_tags
    else
      @user = User.new
      @posts = Post.paginate(:page => params[:page], :per_page => 15, :order => "created_at DESC")
      @groups = Group.paginate(:page => params[:page], :per_page => 15, :order => "created_at DESC")
    end
  end
  
  def about
  end
  
end

# Group.paginate(:page => params[:page], :per_page => 15, :order => "RANDOM()")