class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json

  # before_filter :require_admin_login, :only => [:show, :index]
  before_filter :redirect_to_signup, :except => [:show, :index]

  def index
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end


  #shows the post and creates a transaction object for the "buy" button

  def show
    @post = Post.find(params[:id])
    @transaction = Transaction.new(:post_id => @post.id)

    @appliances = Tag.find_by_id(4)
    @sports = Tag.find_by_id(27)
    @electronics = Tag.find_by_id(36)
    @clothing = Tag.find_by_id(40)
    @books = Tag.find_by_id(21)
    @furniture = Tag.find_by_id(3)

    if @post.tier_id?
      @tier = Tier.find(@post.tier_id)
    end
    if !signed_in?
      @user = User.new
    else
      @user = current_user
    end


    @random_posts = Post.limit(10).order("RANDOM()").select{|x| x.active?} - @user.posts
    @random_posts.delete(@post)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new
    @post.sseller_post = params[:sseller_post]

    @post_categories = PostCategory.all

    @assets = @post.assets
    if !signed_in?
      @post.assets.build
      @user = User.new
      @group = Group.first
      @info_message = "You are not signed up for any groups! If you post this, it will be visible, but nobody will be notified. Below is a random group:"
    else
      @post.assets.build
      @user = current_user
      # @groups = @user.group_feed
      @groups = @user.groups_as_member
      if @groups.empty?
        @groups = Group.first
        @info_message = "You are not signed up for any groups! If you post this, it will be visible, but nobody will be notified. Below is a random group:"
      end
    end
  end

  # GET /posts/1/edit
  def edit
    @post_categories = PostCategory.all
    @post = Post.find(params[:id])
    @assets = @post.assets
    @user = current_user
    @post.assets.build
    # if !signed_in?
    #   @user = User.new
    #   @group = Group.first
    #   @message = "You are not signed up for any groups! If you post this, it will be visible, but nobody will be notified. Below is a random group:"
    # end

  end

  # POST /posts
  # POST /posts.json
  def create
    @post_categories = PostCategory.all
    forsale = @post_categories.find{|a| a.name == "Wanted"}
    @post_categories.delete(forsale)
    @post_categories.unshift(forsale)


    if !current_user && params[:password].present?
      @user = User.new(:email => params[:post][:email], :password => params[:password])
      @post = @user.posts.new(params[:post])

      if !@post.for_sale?
        @post.tier_id = nil
        @post.price = nil
      elsif @post.tier_id?
        @post.price = Tier.find(@post.tier_id).price
      end
      if params[:credit_card_number].present?
        @transaction = @user.transactions.new(:email => @user.email)
        @post.save_customer(@user)
        @user.charge_as_customer(@amount)
        unless !@transaction.save
          render :new
        end
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
      @assets = @post.assets
      if !@post.for_sale?
        @post.tier_id = nil
        @post.price = nil
      end
      # could include elsif here to set lump, hrly rat, other to nil


      @post.email = @user.email

      # if @post.post_category.name == "Textbook"
      #   @textbook_tag = Tag.find_by_id(88)
      #   @post.tag_to(@textbook_tag)
      # end

      if @post.premium?
        @amount = 300
        if @user.stripe_customer_id
          @transaction = @user.transactions.new(:email => @user.email)
          @user.charge_as_customer(@amount)
        elsif params[:credit_card_number].present?
          @transaction = @user.transactions.new
          @transaction.email = @user.email
          @transaction.price = @amount
          @post.save_customer(@user)
          @user.charge_as_customer(@amount)
        end
      end

      if @post.save
        if @transaction && !@transaction.save
          render :new
        end


        @groups = @post.groups
        # all_members = []
        unless @groups.empty?
          send_notification_emails_to_group_members(@groups, @user)
        end

        #if @user.oauth_token.nil? && @post.post_to_facebook == true
        if @post.post_to_facebook == true
          redirect_to user_omniauth_authorize_path(:facebook)
        # elsif @post.post_to_facebook == true && @user.oauth_token
        #   @post.to_facebook
        #   redirect_to @post, notice: "Successfully created post."
        else
          redirect_to @post, notice: "Successfully created post."
        end
      else
        render :new
      end
    #non-signed in muthafuckas who didn't fill in the password field
    else
      @post = Post.new(params[:post])
      if params[:credit_card_number].present?
        #this is wrong
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
      format.html { redirect_to current_user ? user_path(current_user) : root_path }
      format.json { head :no_content }
    end
  end
  def complete
    @post = Post.find(params[:id])
    @post.update_attribute(:completed, true)
    @post.update_attribute(:active, false)
    respond_to do |format|
      format.html { redirect_to @user }
      format.json { head :no_content }
    end
  end

  def undo_completed
    @post = Post.find(params[:id])
    @post.update_attribute(:completed, false)
    @post.update_attribute(:active, true)
    respond_to do |format|
      format.html { redirect_to @user }
      format.json { head :no_content }
    end
  end

  def deactivate
    @post = Post.find(params[:id])
    @post.update_attribute(:active, false)
    respond_to do |format|
      format.html { redirect_to @user }
      format.json { head :no_content }
    end
  end
  def reactivate
    @post = Post.find(params[:id])
    @post.update_attribute(:active, true)
    respond_to do |format|
      format.html { redirect_to @user }
      format.json { head :no_content }
    end
  end

  def sort_name
    @post = Post.new
    @transaction = Transaction.new
    @sort_posts = Post.search()
    @sorted_posts = @sort_posts.result
    if signed_in? && current_user.post_feed.is_a?(Array)
      @user = current_user
      @posts = Post.paginate(:page => params[:page], :per_page => 15, :order => "name DESC")
      #@posts = current_user.post_feed.paginate(:page => params[:page], :per_page => 15, :order => "created_at DESC")
      @groups = current_user.group_feed.paginate(:page => params[:page], :per_page => 15, :order => "created_at DESC")
      @random_groups = Group.paginate(:page => params[:page], :per_page => 15, :order => "RANDOM()")
    else
      @user = User.new
      @posts = Post.paginate(:page => params[:page], :per_page => 15, :order => "name DESC")

      @groups = Group.paginate(:page => params[:page], :per_page => 15, :order => "created_at DESC")
    end
    redirect_to root_path
  end

  def require_admin_login
    unless current_user.admin?
      flash[:error] = "You must be logged in as an admin to access this section #{current_user.admin?}"
      redirect_to 'users/sign_up'
    end
  end

  def store_location
    session[:user_return_to] = request.url
    #session[:return_to] = root_path
    #setting to root here because it redirects to sign up when the user tries to access /followships

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



  private
  def send_notification_emails_to_group_members(groups, user)
    all_memberships = []
    for group in @groups do
      Membership.where(:group_id => group.id).each do |membership|
        all_memberships << membership
      end
    end
    all_memberships = all_memberships.uniq
    every_posts = []
    every_posts = all_memberships.select{|membership| membership.email_setting_id == 1}
    no_email_settings = []
    no_email_settings = all_memberships.select{|membership| membership.email_setting_id == nil}
    daily_memberships = []
    daily_memberships = all_memberships.select{|membership| membership.email_setting_id == 2}
    weekly_memberships = []
    weekly_memberships = all_memberships.select{|membership| membership.email_setting_id == 3}
    daily_aggs = []
    daily_aggs = all_memberships.select{|membership| membership.email_setting_id == 4}
    weekly_aggs = []
    weekly_aggs = all_memberships.select{|membership| membership.email_setting_id == 5}
    off = []
    off = all_memberships.select{|membership| membership.email_setting_id == 6}
    #*************************************************************************************

    for every_post in every_posts do
      user = User.find(every_post.member_id)
      NewPostMailer.notify(@user, @post, user, group).deliver
    end
    for daily_membership in daily_memberships do
      user = User.find(daily_membership.member_id)
      group = Group.find(daily_membership.group_id)
      DailyQueue.create(:sender_id => @user.id, :post_id => @post.id, :user_id => user.id, :group_id => group.id)
    end
    for weekly_membership in weekly_memberships do
      user = User.find(weekly_membership.member_id)
      group = Group.find(daily_membership.group_id)
      WeeklyQueue.create(:sender_id => @user.id, :post_id => @post.id, :user_id => user.id, :group_id => group.id)
    end
  end




end
