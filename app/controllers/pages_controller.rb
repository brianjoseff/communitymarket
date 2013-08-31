class PagesController < ApplicationController
  # skip_before_filter :require_login
  # skip_before_filter :authorize
  require 'will_paginate/array' 
  
  def index

    @post = Post.new
    @transaction = Transaction.new
    @sort_posts = Post.search()
    @sorted_posts = @sort_posts.result
    if signed_in? && current_user.post_feed.is_a?(Array)
      @user = current_user
      #@posts = Post.all.select{|x| x.active?}.paginate(:page => params[:page], :per_page => 35, :order => "created_at DESC")
      @posts = Post.all.select{|x| x.active?}.sort { |x,y| y.created_at <=> x.created_at }
      @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(35)
      #@posts = current_user.post_feed.paginate(:page => params[:page], :per_page => 15, :order => "created_at DESC")
      @groups = current_user.group_feed.paginate(:page => params[:page], :per_page => 15, :order => "created_at DESC")
      unless @location.nil?
        @near_groups = Group.near(@location.first.city, 10000)
      end
      @random_groups = Group.last(20) - @user.groups_as_member
      @followed_tags = @user.followed_tags
    else
      #must sort them in opposite order because of the way the partials are rendered?
      @posts = Post.all.select{|x| x.active?}.sort { |x,y| y.created_at <=> x.created_at }
      @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(35)
      
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
      
      #@posts = @entries.paginate(:page => params[:page], :per_page => 35, :order => "created_at DESC")
      @groups = Group.paginate(:page => params[:page], :per_page => 15, :order => "created_at DESC")
      @random_groups = Group.last(20) - @user.groups_as_member
    end
  end
  
  def about
  end
  
end

# Group.paginate(:page => params[:page], :per_page => 15, :order => "RANDOM()")