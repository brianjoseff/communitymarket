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
    #@categories = PostCategory.all
    
    if !current_user && params[:password].present?
      @user = User.new(:email => params[:post][:email], :password => params[:password])
      @post = @user.posts.new(params[:post])
      if params[:credit_card_number].present?
        @transaction = @user.transactions.new(:email => @user.email)
        @post.save_customer(@user)
        @user.charge_as_customer(@amount)
      end
      if @post.save && @user.save
        SignupMailer.new_subscriber(@user).deliver
        sign_in @user
        redirect_to @post, notice: "Successfully created post."
      else
        render :new
      end
    elsif current_user
      @user = current_user
      @post = @user.posts.new(params[:post])
      @post.email = @user.email
      if params[:credit_card_number].present?
        @amount = 300
        if @user.stripe_customer_id
          @transaction = @user.transactions.new(:email => @user.email)
          @user.charge_as_customer(@amount)
        else
          @transaction = @user.transactions.new
          @transaction.email = @user.email
          @transaction.price = @amount
          @post.save_customer(@user)
          @user.charge_as_customer(@amount)
        end
      end
      if @post.save        
        #!!!!!!!!!!
        #need to add a dedupe process here
        @groups = @post.groups
        #all_members = []
        unless @groups.empty?
          for group in @groups do
            members = group.members
            #all_members << members
            for member in members do
              NewPostMailer.notify(@user, @post, member, group).deliver
            end
          end
          # all_members.uniq
          # for member in all_members do
          #   NewPostMailer.notify(@user, @post, member, group).deliver
          # end
        end
        redirect_to @post, notice: "Successfully created post."
      else
        render :new
      end
    #non-signed in muthafuckas who didn't fill in the password field
    else
      @post = Post.new(params[:post])
      if params[:credit_card_number].present?
        @user.save_as_customer
        @user.charge(@amount)
      end
      if @post.save
        redirect_to @post, notice: "Successfully created post."
      else
        render :new
      end
    end
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
  
  def deactivate
    @post = Post.find(params[:id])
    @post.update_attribute(:active, false)
    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
  end
  def reactivate
    @post = Post.find(params[:id])
    @post.update_attribute(:active, true)
    respond_to do |format|
      format.html { redirect_to root_path }
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
