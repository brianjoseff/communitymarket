class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @transaction = Transaction.new
    @post = Post.find(params[:id])
    if !signed_in?
      @user = User.new
    else
      @user = current_user
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new
    @categories = PostCategory.all
    
    @assets = @post.assets
    if !signed_in?
      @post.assets.build
      @user = User.new
      @group = Group.first
      @message = "You are not signed up for any groups! If you post this, it will be visible, but nobody will be notified. Below is a random group:"
    else
      @post.assets.build
      @user = current_user
      @groups = @user.group_feed
      if @groups.empty?
        @groups = Group.first
        @message = "You are not signed up for any groups! If you post this, it will be visible, but nobody will be notified. Below is a random group:"
      end
    end
  end

  # GET /posts/1/edit
  def edit
    @categories = PostCategory.all
    @post = Post.find(params[:id])
    @assets = @post.assets
    if !signed_in?
      @user = User.new
      @group = Group.first
      @message = "You are not signed up for any groups! If you post this, it will be visible, but nobody will be notified. Below is a random group:"
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @categories = PostCategory.all
    
    if signed_in?
      @user = current_user
      @post = @user.posts.build(params[:post])
      @post.email = @user.email
      @assets = @post.assets
      if @post.save
        @groups = @post.groups
        unless @groups.empty?
          for group in @groups do
            members = group.members
            for member in members do
              NewPostMailer.notify(@user, @post, @post.post_category.name, member, group).deliver
            end
          end
        end
        redirect_to @post, notice: "Successfully created post."
      else
        render :new
      end
    else
      @post = Post.new(params[:post])
      @assets = @post.assets
      #if password field filled out
        #make user
      #end
      if @post.save
        @groups = @post.groups
        unless @groups.empty?
          for group in @groups do
            members = group.members
            for member in members do
              NewPostMailer.new_post(@user, @post, @post.product_category.name, member, group).deliver
            end
          end
        end
        redirect_to @post, notice: "Successfully created post."
      else
        render :new
      end
    end
    # respond_to do |format|
    #       if @post.save
    #         format.html { redirect_to @post, notice: 'Post was successfully created.' }
    #         format.json { render json: @post, status: :created, location: @post }
    #       else
    #         format.html { render action: "new" }
    #         format.json { render json: @post.errors, status: :unprocessable_entity }
    #       end
    #     end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end
  
  def setup_post(post)
    if current_user
      if post.groups
        groups = current_user.groups_as_owner + current_user.groups_as_member 
        (groups - post.groups).each do |group|
          post.assignments.build(:group_id => group.id)
        end
        post.assignments.sort_by {|x| x.group.name }
        asset = post.assets.build
        post
      else
        post.errors_message("you aren't signed up to any groups")
        post
      end
    else
      return
    end
  end
end
