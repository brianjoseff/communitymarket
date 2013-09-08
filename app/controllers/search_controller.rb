class SearchController < ApplicationController
  #search implemented with Ransack gem
  def index
    @q = Group.search(params[:q])
    @groups = @q.result
    @group_count = @groups.count
    
    #query = params[:q][:name_cont]
    
    # params[:q].each do |key,value|
    #   params["q"][key] = "title_cont"
    # end
    @q2 = Post.search({:title_cont => params[:q][:name_cont]})
    #@q2 = Post.search(params[:q])
    @posts_results = @q2.result
    @posts_results = Kaminari.paginate_array(@posts_results).page(params[:page]).per(35)
    @post_count = @posts_results.count
    @posts = @posts_results
    
    #Add search array for tags
    
    
  end
end