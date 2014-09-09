class PagesController < ApplicationController
  # skip_before_filter :require_login
  # skip_before_filter :authorize
  require 'will_paginate/array' 
  def feed      
    if params[:cat]
      @post_category= PostCategory.find_by_name(params[:cat])
      @posts = @post_category.posts.select{|x| x.active?}.sort { |x,y| y.created_at <=> x.created_at }
      @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(50)
    else
      @posts = Post.all.select{|x| x.active?}.sort { |x,y| y.created_at <=> x.created_at }
      @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(50)
    end
    respond_to do |format|
       format.html
       format.js
       format.json { render json: @posts }
     end
  end
  
  def index
    @post = Post.new
    @post_categories = PostCategory.pluck(:name)
    @post_categories << "All"
    
    @transaction = Transaction.new
    
    @sort_posts = Post.search()
    @sorted_posts = @sort_posts.result
    
    @popular_tags = get_popular_tags
    # @ranked_users = User.all.first(5)
    
    #VERY BRITTLE CODE HERE
    # For "Browse by Category" feature on search bar
    # @appliances = Tag.find_by_id(4)
    # @sports = Tag.find_by_id(27)
    # @electronics = Tag.find_by_id(36)
    # @clothing = Tag.find_by_id(40)
    # @books = Tag.find_by_id(21)
    # @furniture = Tag.find_by_id(3)
    # @full_post_categories = PostCategory.all
    # @browse_by_array_tags = [@appliances, @sports, @electronics, @clothing, @books, @furniture]
    # @browse_by_array = []
    # @browse_by_array_tags.each do |a|
    #   if !a.nil?
    #     @browse_by_array << a
    #   end
    # end
    # @full_post_categories.each do |c|
    #   @browse_by_array << c
    # end
    # 
    # @browse_by_array.sort! {|a,b| (a.name.downcase <=> b.name.downcase) || nil}
    
    if signed_in? # && current_user.post_feed.is_a?(Array)
      @user = current_user
      #OLD######@posts = Post.all.select{|x| x.active?}.paginate(:page => params[:page], :per_page => 35, :order => "created_at DESC")
      # @posts = Post.all.select{|x| x.active?}.sort { |x,y| y.created_at <=> x.created_at }
      # @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(50)
      
      
      if params[:categorize] && params[:categorize] != "All" 
        @post_category= PostCategory.find_by_name(params[:categorize])
        @posts = filter_posts(@post_category.posts).sort { |x,y| y.created_at <=> x.created_at }
        @posts = kaminari_paginate(@posts, 50)
      else
        @posts = filter_posts(Post.all).sort { |x,y| y.created_at <=> x.created_at }
        #@posts = Post.all.select{|x| x.active?}.sort { |x,y| y.created_at <=> x.created_at }
        @posts = kaminari_paginate(@posts, 50) 
      end
      @your_groups = current_user.groups_as_member
      unless @location.first.nil?
        @near_groups = Group.near(@location.first.city, 10000)
        @near_groups = @near_groups.sort {|x,y| x.name <=> y.name}
      end
      @random_groups = Group.last(20) - @user.groups_as_member
      @random_groups = @random_groups.sort {|x,y| x.name <=> y.name}
      @followed_tags = @user.followed_tags
    else

      if params[:categorize] && params[:categorize] != "All" 
        @post_category= PostCategory.find_by_name(params[:categorize])
        @posts = filter_posts(@post_category.posts).sort { |x,y| y.created_at <=> x.created_at }
        @posts = kaminari_paginate(@posts, 50)
      else
        @posts = filter_posts(Post.all).select{|x| x.active?}.sort { |x,y| y.created_at <=> x.created_at }
        @posts = kaminari_paginate(@posts, 50)
      end
      @random_tags = Tag.last(5)
      @user = User.new
      unless @location.first.nil?
        @near_groups = Group.near(@location.first.city, 10000)
        @near_groups = @near_groups.sort {|x,y| x.name <=> y.name}
      end
      @random_groups = Group.last(20) - @user.groups_as_member
      @random_groups = @random_groups.sort {|x,y| x.name <=> y.name}
    end 
    respond_to do |format|
       format.html # index.html.erb
       format.js # index.js.erb
       format.json { render json: @posts }
     end 
  end
  
  
  def borrow_rent
    @post_category = PostCategory.find(4)
    @post = Post.new
    @transaction = Transaction.new
    @sort_posts = Post.search()
    @sorted_posts = @sort_posts.result
    if signed_in? # && current_user.post_feed.is_a?(Array)
      @user = current_user
      #@posts = Post.all.select{|x| x.active?}.paginate(:page => params[:page], :per_page => 35, :order => "created_at DESC")
      @posts = nil
      @posts = filter_posts(@post_category.posts)
      #@posts = @post_category.posts.select{|x| x.active? || !x.active? && x.completed?}.sort { |x,y| y.created_at <=> x.created_at }
      @posts = kaminari_paginate(@posts, 50)
      #@posts = current_user.post_feed.paginate(:page => params[:page], :per_page => 15, :order => "created_at DESC")
      @your_groups = current_user.group_feed
      unless @location.nil?
        @near_groups = Group.near(@location.first.city, 10000)
      end
      @random_groups = Group.last(20) - @user.groups_as_member
      @followed_tags = @user.followed_tags
    else
      #must sort them in opposite order because of the way the partials are rendered?
      @posts = @post_category.posts.select{|x| x.active?}.sort { |x,y| y.created_at <=> x.created_at }
      @posts = kaminari_paginate(@posts, 50)
      
      #@page_results = @posts.paginate(:page => params[:page], :per_page => 35, :order => "created_at DESC")
      # @posts = WillPaginate::Collection.create(1, 35, nil) do |pager|
      #   result = Post.find(:all, :order => "created_at DESC", :limit => pager.per_page, :offset => pager.offset)
      #   #result = Post.all.select{|x| x.active?}
      #   # inject the result array into the paginated collection:
      #   pager.replace(result)
      # 
      #   unless pager.total_entries
      #     # the pager didn't manage to guess the total count, do it manually
      #     pager.total_entries = Post.count
      #   end
      # end
      @user = User.new
      unless @location.nil?
        @near_groups = Group.near(@location.first.city, 10000)
      end
      #@posts = @entries.paginate(:page => params[:page], :per_page => 35, :order => "created_at DESC")
      #@groups = Group.paginate(:page => params[:page], :per_page => 15, :order => "created_at DESC")
      @random_groups = Group.last(20) - @user.groups_as_member
    end
  end
  
  def about
  end
  
  def jobs
  end
  
  def textbooks
    @transaction = Transaction.new
    # @post_category= Tag.find_by_id(88)
    # @posts = @post_category.posts.select{|x| x.active?}.sort { |x,y| y.created_at <=> x.created_at }
    # @posts = kaminari_paginate(@posts, 50) 
    # respond_to do |format|
    #     format.js { render :layout=>false }
    # end
    @pc = PostCategory.find_by_name("Textbook")
    @tag = Tag.find_by_id(88)
    @classes = []
    if !@tag.nil?
      @posts = filter_posts(@tag.posts).sort { |x,y| y.created_at <=> x.created_at }
      @posts = kaminari_paginate(@posts, 50)
      
      # @posts = @tag.posts.select{|x| x.active?}.sort { |x,y| y.created_at <=> x.created_at }
      #       @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(50)
	  else
	    @posts = Post.first(10)
	    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(50)
    end
    
    
  end
  
  def dorm_furniture
    @post_category= Tag.find_by_id(3)
    @posts = @post_category.posts.select{|x| x.active?}.sort { |x,y| y.created_at <=> x.created_at }
    @posts = kaminari_paginate(@posts, 50)
    respond_to do |format|
        format.js { render :layout=>false }
    end
  end
  
  
  private
  
  def filter_posts(posts)
    posts = posts.select do |post|
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
  

  def landing
  end
  
  private

  def get_popular_tags
    adapter_type = ActiveRecord::Base.connection.adapter_name.downcase.to_sym
    case adapter_type
    when :mysql
      # do the MySQL part
    when :sqlite
      # do the SQLite3 part
      Tag.joins(:taggings).select('tags.*, count(tag_id) as "tag_count"').group(:tag_id).order(' tag_count desc').first(5)
    when :postgresql
      Tag.joins(:taggings).select('tags.*, count(tag_id) as "tag_count"').group('tags.id').order(' tag_count desc').first(5)

    else
      raise NotImplementedError, "Unknown adapter type '#{adapter_type}'"
    end
    
  end
end

# Group.paginate(:page => params[:page], :per_page => 15, :order => "RANDOM()")