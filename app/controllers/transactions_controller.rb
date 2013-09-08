class TransactionsController < ApplicationController
  # GET /transactions
  # GET /transactions.json
  def index
    @transactions = Transaction.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @transactions }
    end
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
    @transaction = Transaction.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @transaction }
    end
  end

  # GET /transactions/new
  # GET /transactions/new.json
  def new
    @transaction = Transaction.new
    @user = User.new
    flash[:the_post_id] = params[:post_id]
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @transaction }
      # if request.xhr?
      #    format.html { render 'new_modal'}
      #  else
      #    format.html
      #    #format.json { render :json => @transaction }
      #  end
    end
  end

  # GET /transactions/1/edit
  def edit
    @transaction = Transaction.find(params[:id])
  end

  # POST /transactions
  # POST /transactions.json
  
  def create
    if @post = Post.where(:id => flash[:the_post_id]).first
    #@price = @post.price
      @tier_id = @post.tier_id
      @amount = @tier_id*100
    else
      @amount = 1000
    end
    
    #@token = flash[:token]
    #@token = params[:transaction][:stripe_card_token]
    respond_to do |format|
      
      #-------------------------------------------------------------------------------------------#
      #---- Sign Up and Pay at Same time...[working] ---------------------------------------------#
      #-------------------------------------------------------------------------------------------#
      #non-user encountered form and entered credit details AND password- signing up and paying
      if !current_user && params[:password].present?        
        @user = User.new(:email => params[:transaction][:email], :password => params[:password])
        #@user.save_as_customer(params[:transaction][:email], @token)
        # @user.save_as_customer
        @transaction = @user.transactions.new(params[:transaction].merge(:price => @amount))
        @transaction.save_customer(@user)
        # customer = Stripe::Customer.create( :description => email, :card => params[:stripe_card_token])
        # @user.stripe_customer_id = customer.id
        if @transaction.save && @user.save
          @user.charge_as_customer(@amount)
          sign_in @user
          #format.js { render }
          @post.deactivate
          format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
          format.json { render json: @transaction, status: :created, location: @transaction }
        else
          format.html { render action: "new" }
          format.json { render json: @transaction.errors, status: :unprocessable_entity }
        end
        
      #-------------------------------------------------------------------------------------------#
      #---- Current User and Customer... [not working]--------------------------------------------#
      #-------------------------------------------------------------------------------------------#  
      elsif current_user && current_user.stripe_customer_id
      #already gots that CC info--- just charge 'em  
        @user = current_user
        @transaction = @user.transactions.new(params[:transaction].merge(:price => @amount).merge(:email => @user.email))
        @transaction.save_customer(@user)
        if @transaction.save
          @user.charge_as_customer(@amount)
          @post.deactivate!
          format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
          format.json { render json: @transaction, status: :created, location: @transaction }
          
        else
          format.html { render action: "new" }
          format.json { render json: @transaction.errors, status: :unprocessable_entity }
        end
      #-------------------------------------------------------------------------------------------#
      #---- Current User and Non-Customer... [not working]--------------------------------------------#
      #-------------------------------------------------------------------------------------------#
      elsif current_user && !current_user.stripe_customer_id
        #current_user without credit details encountered form
        @user = current_user
        # @user.update_payment_details(@user.email, @token)
        # @user.charge_as_customer(@amount)
        @transaction = @user.transactions.new(params[:transaction].merge(:price => @amount).merge(:email => @user.email))
        @transaction.save_customer(@user)
        if @transaction.save
          @user.charge_as_customer(@amount)
          @post.deactivate!
          format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
        else
          format.html { render action: "new" }
          format.json { render json: @transaction.errors, status: :unprocessable_entity }
        end
      else
        #non-user encountered form and didn't enter password
        @transaction = Transaction.new(params[:transaction].merge(:price => @amount))
        if @transaction.save
          @transaction.charge(amount, @token, email)
          format.js { render }
        else
          format.html { render action: "new" }
          format.json { render json: @transaction.errors, status: :unprocessable_entity }
        end      
      end
    end
  end

  # PUT /transactions/1
  # PUT /transactions/1.json
  def update
    @transaction = Transaction.find(params[:id])

    respond_to do |format|
      if @transaction.update_attributes(params[:transaction])
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def customer_purchase
    
    @user = current_user
    @transaction = @user.transactions.new(:premium => @premium, :notify_premium => @notify_premium, :tier_id => @tier_id, :price => @amount, :email => @user.email)
    if @post = Post.find(params[:transaction][:post_id])
    #@price = @post.price
      @tier_id = @post.tier_id
      @amount = @tier_id*100
    else
      @notify_premium = params[:notify_premium]
      @premium = params[:premium]
      @amount = 1000
    end
    
    
    respond_to do |format|
      if @transaction.save
        @user.charge_as_customer(@amount)
        @post.deactivate!
      
        format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
        format.json { render json: @transaction, status: :created, location: @transaction }
      
      else
        format.html { render action: "new" }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to transactions_url }
      format.json { head :no_content }
    end
  end
  
end
