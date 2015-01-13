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
    if signed_in
        @school = School.find(current_user.school_id)
        @posts = filter_posts(@q2.result.where(school_id: @school.id)).sort { |x,y| y.created_at <=> x.created_at }
        @posts = kaminari_paginate(@posts, 50)
    else
        @posts = filter_posts(@q2.result.sort { |x,y| y.created_at <=> x.created_at }
        @posts = kaminari_paginate(@posts, 50)
    end
    
    #@q2 = Post.search(params[:q])
    # @posts_results = @q2.result.select{|x| x.active?}.sort { |x,y| y.created_at <=> x.created_at }
    # @posts_results = Kaminari.paginate_array(@posts_results).page(params[:page]).per(35)
    @post_count = @posts.count
    
    
    @q3 = Tag.search({:name_cont => params[:q][:name_cont]})
    @tag_results = @q3.result
    #Add search array for tags
    
    
  end

  private
    def filter_posts(posts)
    posts = posts.select do |post|
      # puts "USERUSEURSEUR: #{user}"
      # unless user.empty?
      #   if post.school_id != user.first.school_id
      #     false
      #   end
      # end

      case
      when post.active?
        true
      when !post.active? && post.completed?
        true
      else
        false
      end
    end
    return posts
  end
  
  def kaminari_paginate(posts, per_page)
    Kaminari.paginate_array(posts).page(params[:page]).per(per_page)
  end
end