class ApplicationController < ActionController::Base
  include Clearance::Authentication
  protect_from_forgery
  before_filter :get_search_object, :set_user, :get_location
  
  
  #sets user instance variable for the "new user" button in the nav
  def set_user
    if !current_user
      @user = User.new
    end
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
end
