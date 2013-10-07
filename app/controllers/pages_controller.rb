class PagesController < ApplicationController
  # skip_before_filter :require_login
  # skip_before_filter :authorize
  require 'will_paginate/array' 
  
  def index

    @post = Post.new
    @transaction = Transaction.new
    @sort_posts = Post.search()
    @sorted_posts = @sort_posts.result
    @popular_tags = get_popular_tags
    if signed_in? # && current_user.post_feed.is_a?(Array)
      @user = current_user
      #@posts = Post.all.select{|x| x.active?}.paginate(:page => params[:page], :per_page => 35, :order => "created_at DESC")
      @posts = Post.all.select{|x| x.active?}.sort { |x,y| y.created_at <=> x.created_at }
      @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(50)
      #@posts = current_user.post_feed.paginate(:page => params[:page], :per_page => 15, :order => "created_at DESC")
      @your_groups = current_user.groups_as_member
      unless @location.nil?
        @near_groups = Group.near(@location.first.city, 10000)
      end
      @random_groups = Group.last(20) - @user.groups_as_member
      @followed_tags = @user.followed_tags
    else
      #must sort them in opposite order because of the way the partials are rendered?
      @posts = Post.all.select{|x| x.active?}.sort { |x,y| y.created_at <=> x.created_at }
      @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(50)
      @random_tags = Tag.last(5)
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
  
  def wanted
    @post_category = PostCategory.find(2)
    @post = Post.new
    @transaction = Transaction.new
    @sort_posts = Post.search()
    @sorted_posts = @sort_posts.result
    if signed_in? # && current_user.post_feed.is_a?(Array)
      @user = current_user
      #@posts = Post.all.select{|x| x.active?}.paginate(:page => params[:page], :per_page => 35, :order => "created_at DESC")
      @posts = @post_category.posts.select{|x| x.active?}.sort { |x,y| y.created_at <=> x.created_at }
      @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(50)
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
      @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(50)
      
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
  def for_sale
    @post_category = PostCategory.find(1)
    @post = Post.new
    @transaction = Transaction.new
    @sort_posts = Post.search()
    @sorted_posts = @sort_posts.result
    if signed_in? # && current_user.post_feed.is_a?(Array)
      @user = current_user
      #@posts = Post.all.select{|x| x.active?}.paginate(:page => params[:page], :per_page => 35, :order => "created_at DESC")
      @posts = @post_category.posts.select{|x| x.active?}.sort { |x,y| y.created_at <=> x.created_at }
      @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(50)
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
      @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(50)
      
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
  def borrow_rent
    @post_category = PostCategory.find(4)
    @post = Post.new
    @transaction = Transaction.new
    @sort_posts = Post.search()
    @sorted_posts = @sort_posts.result
    if signed_in? # && current_user.post_feed.is_a?(Array)
      @user = current_user
      #@posts = Post.all.select{|x| x.active?}.paginate(:page => params[:page], :per_page => 35, :order => "created_at DESC")
      @posts = @post_category.posts.select{|x| x.active?}.sort { |x,y| y.created_at <=> x.created_at }
      @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(50)
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
      @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(50)
      
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