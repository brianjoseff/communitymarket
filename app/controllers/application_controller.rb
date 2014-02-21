class ApplicationController < ActionController::Base
  #include Clearance::Authentication
  protect_from_forgery
  before_filter :get_search_object, :set_user, :get_location, :set_message, :update_last_sign_in_at, :get_category_tags
  def get_category_tags
    @appliances = Tag.find_by_id(4)
    @sports = Tag.find_by_id(27)
    @electronics = Tag.find_by_id(36)
    @clothing = Tag.find_by_id(40)
    @books = Tag.find_by_id(21)
    @furniture = Tag.find_by_id(3)
  end
  
  def after_sign_in_path_for(resource) 
    if session[:followed_tag]
      @tag = Tag.find(session[:followed_tag])
      current_user.follow!(@tag)
      session.delete(:followed_tag)
      flash[:notice] = "You've followed a tag"
    end
    if session[:joined_group]
      @group = Group.find(session[:joined_group])
      current_user.join!(@group)
      session.delete(:joined_group)
      flash[:notice] = "You've joined a group"
    end
    if session[:user_return_to]
      if flash[:notice]
        flash[:notice] += " and successfully signed in."
      end
      session[:user_return_to]
      session.delete(:user_return_to)    
    else
      root_path
    end
  end
  
  def set_message
    @message = Message.new
  end
  
  #sets user instance variable for the "new user" button in the nav
  def set_user
    if !user_signed_in?
      @user = User.new
    else
      @user = current_user
    end
    # if !current_user
    #   @user = User.new
    # end
  end
  
  def get_location
    ip = request.ip
    @location = Geocoder.search(ip)
  end
  
  #since this is run as an application before_filter,
  #the search object is available on every page.
  #Therefore, a search bar may be placed on every page
  def get_search_object
    @q = Post.search(params[:q])
    @posts = @q.result
    @q = Group.search(params[:q])
    @groups = @q.result
  end
  
  
  def get_categories
    @categories = PostCategory.all
    @other_categories = GroupCategory.all
  end
  
  def get_post_categories
    @forsale = PostCategory.find_by_id(1)
    @wanted = PostCategory.find_by_id(2)
    @jobs = PostCategory.find_by_id(3)
    @free = PostCategory.find_by_id(4)
    @housing = PostCategory.find_by_id(5)
  end
  
  def require_admin_login
    unless signed_in? && current_user.admin?
      flash[:error] = "You must be logged in as an admin to access this section"
      redirect_to signin_path
    end
  end
  protected

  def update_last_sign_in_at
    if user_signed_in? && !session[:logged_signin]
      sign_in(current_user, :force => true)
      session[:logged_signin] = true
    end
  end
end
