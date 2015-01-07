class GroupsController < ApplicationController
  # GET /groups
  # GET /groups.json
  def index
    if params[:zipcode]
      zipcode = params[:zipcode]
      @groups = Group.near(zipcode, 1000)
    else
      @groups = filter_groups(Group.all, current_user)
    end
    @g_categories = GroupCategory.all
    # respond_to do |format|
    #   format.html # index.html.erb
    #   format.js #index.js.erb
    #   format.json { render json: @groups }
    # end
    # 
    
    @group_attributes = Group.columns
     if params[:sort]
       @groups= Group.order(params[:sort])
     else
       @groups = filter_groups(Group.order(:name), current_user)
     end 

     respond_to do |format|
       format.html # index.html.erb
       format.js # index.js.erb
       format.json { render json: @groups }
     end 
    
  end
  
  def bulk_update
    Membership.where(:id => params[:delete]).destroy_all
    @group = Group.find(params[:group_id])
    respond_to do |format|
      format.html { redirect_to @group }
      format.json { head :no_content }
    end
  end
  
  def bulk_groups_update
    Membership.where(:id => params[:delete]).destroy_all
    @group = Group.find(params[:group_id])
    respond_to do |format|
      format.html { redirect_to @group }
      format.json { head :no_content }
    end
  end 
  
  
  # def nearby
  #     zipcode = 
  #     
  #     
  #     @g_categories = GroupCategory.all
  #     respond_to do |format|
  #       #format.html
  #       format.json  { render :json => @groups }
  #       #format.json { render :json => {:bathrooms => @bathrooms} }
  #       format.js   { render :nothing => true } 
  #      end        
  #   end
    
  # GET /groups/1
  # GET /groups/1.json
  def show
    @group = Group.find(params[:id])

    @posts = filter_posts(@group.posts).sort { |x,y| y.created_at <=> x.created_at }
    @posts = kaminari_paginate(@posts, 50)
    
    @random_groups = Group.last(20) - @user.groups_as_member
    if !signed_in?
      @user = User.new
    else
      @user = current_user
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @group }
    end
  end

  # GET /groups/new
  # GET /groups/new.json
  def new
    
    @group = Group.new
    @categories = GroupCategory.all
    @group.assets.build
    @assets = @group.assets
    @school = School.find(current_user.school_id)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @group }
    end
  end

  # GET /groups/1/edit
  def edit
    @group = Group.find(params[:id])
    @group.assets.build
    @assets = @group.assets
    @categories = GroupCategory.all
  end

  # POST /groups
  # POST /groups.json
  def create
    ip = request.location
    @user = current_user
    @group = @user.groups_as_owner.new(params[:group])
    params[:group][:member_ids] = (params[:group][:member_ids] << @group.member_ids).flatten
    @group.school_id = @user.school_id
    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render json: @group, status: :created, location: @group }
      else
        format.html { render action: "new" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /groups/1
  # PUT /groups/1.json
  def update
    @group = Group.find(params[:id])
    params[:group][:member_ids] = (params[:group][:member_ids] << @group.member_ids).flatten

    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to root_path }
        format.js
        # format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        #         format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # NEEDS SUCCESS MESSAGE
  def private
    @group = Group.find(params[:group_id])
    params[:group][:member_ids] = (params[:group][:member_ids] << @group.member_ids).flatten
    
    respond_to do |format|
      if params[:password] == @group.password && @group.update_attributes(params[:group])
        flash[:success] = "Successfully joined #{@group.name}"
        format.html { redirect_to root_path }
        format.js
        # format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        #         format.json { head :no_content }
      else
        if params[:password] != @group.password
          flash.now[:wrong_password] = "Wrong Password"
        end
        format.html { render action: "show"}
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    respond_to do |format|
      format.html { redirect_to groups_url }
      format.json { head :no_content }
    end
  end
  
  private
  def kaminari_paginate(posts, per_page)
    Kaminari.paginate_array(posts).page(params[:page]).per(per_page)
  end
  
  def filter_groups(groups, user)
    groups = groups.select do |group|
      if groups.nil? || user.nil?
        true
      else
        case      
        when group.school_id != user.school_id
          false
        else
          true
        end
      end
    end
  end

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
  
end
