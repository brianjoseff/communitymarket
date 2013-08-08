class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    if (7.days.ago..Time.now).cover?(@user.created_at)
      location = request.remote_ip
      @groups = Group.near(location, 20)
    end
    
    @posts = @user.posts
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end
  
  # def new_modal
  #   @user = User.new(params[:user])
  #   
  #   if params[:user][:password].nil?
  #     # charge card
  # 
  #     # get the credit card details submitted by the form
  #     token = params[:stripeToken]
  # 
  #     # create the charge on Stripe's servers - this will charge the user's card
  #     charge = Stripe::Charge.create(
  #       :amount => 1000, # amount in cents, again
  #       :currency => "usd",
  #       :card => token,
  #       :description => params[:email]
  #     )
  #     
  #   else
  #     # create user
  #     token = params[:stripeToken]
  #     if @user.save_with_payment(token)
  #       @user.payment()
  #     else
  #       #error message
  #     end
  #     #create customer and charge
  #   end
  # end
  
  
  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      #format.html { render 'new_modal', layout: false } if request.xhr?
      format.html
      format.js
      #format.json { render json: @user }
    end
  end
  
  def new_modal
    @user = User.new

    respond_to do |format|
      format.html { render 'new_modal', layout: false } if request.xhr?
      #format.js
      format.json { render json: @user }
    end
  end
  

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])

  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    #@user.save
    # if @user.valid?
    #    flash[:notice] = 'You have successfully signed your soul away.'
    #  end
    respond_to do |format|
      # format.js{render 'create'}
      # format.html {
      #   if @user.valid?
      #     #sign_in @user
      #     redirect_to root_path
      #     #render partial: 'table', locals: { animal_handbooks: @animal_handbooks }
      #   else
      #     render 'new_modal', layout: false
      #   end
      # } if request.xhr?
      
      if @user.save
              #SignupMailer.new_subscriber(@user).deliver
              sign_in @user
              format.html { redirect_to root_path, notice: "Thank you for signing up!" }
              format.json { render json: @user, status: :created, location: @user }
              # format.js {'create'}
            else
              format.html { render action: "new" }
              format.json { render json: @user.errors, status: :unprocessable_entity }
              #format.js
            end
    end
    #flash.discard :notice if request.xhr?
    # AJAX efforts
    # respond_to do |format|
    #       if params[:user][:password].empty?
    #         # Charge the card and don't make a user
    #         # get the credit card details submitted by the form
    #         token = params[:stripeToken]
    # 
    #         # create the charge on Stripe's servers - this will charge the user's card
    #         charge = Stripe::Charge.create(
    #           :amount => 1000, # amount in cents, again
    #           :currency => "usd",
    #           :card => token,
    #           :description => params[:email]
    #         )
    #         
    #       else
    #         # create user, customer, and charge them
    #         token = params[:stripeToken]
    #         if @user.save_with_payment(token)
    #           charge = 100
    #           @user.payment(charge)
    #           format.html { redirect_to @user, notice: 'User was successfully created.' }
    #           format.json { render json: @user, status: :created, location: @user }
    #           format.js
    #         else
    #           #error message
    #           format.html { render action: "new" }
    #           format.json { render json: @user.errors, status: :unprocessable_entity }
    #           format.js
    #         end
    #       end
    #@user = User.new(params[:user])
  end


  def update_dom
    #render :template => "layouts/header", :layout => false
    format.js {"create"}
  end
  
  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def add_image
    @user = current_user
    @image = @user.build(params[:image])
  end
  
  

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
