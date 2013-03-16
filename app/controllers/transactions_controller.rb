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

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @transaction }
    end
  end

  # GET /transactions/1/edit
  def edit
    @transaction = Transaction.find(params[:id])
  end

  # POST /transactions
  # POST /transactions.json
  def create
    @post = Post.find_by_id(params[:post_id])
    @price = @post.price
    @tier_id = @post.tier_id
    if current_user
      @user = current_user
      @transaction = @user.transactions.build(params[:transaction].merge(:price => @price).merge(:email => @user.email))
    else
      @transaction = Transaction.new(params[:transaction].merge(:price => @price))
      @user = User.new(:email => params[:transaction][:email], :password => params[:password])
    end
    respond_to do |format|
<<<<<<< HEAD
      if params[:password].present?
        if @transaction.save
          @user.save_with_payment
=======
      #non-user encountered form and entered credit details AND password- signing up and paying
      if !current_user && params[:password].present?
        if @transaction.save! && @user.save_with_payment
          #@user.payment(@price)
          @transaction.payment(params[:transaction][:tier_id], @price, params[:transaction][:premium],params[:transaction][:premium_notify])
          sign_in @user
          format.js {render}
>>>>>>> branch
          format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
          format.json { render json: @transaction, status: :created, location: @transaction }
        else
          format.html { render action: "new" }
          format.json { render json: @transaction.errors, status: :unprocessable_entity }
        end
      elsif current_user
        #current_user without credit details encountered form
        @user.stripe_customer_id = @transaction.save_with_payment
        if @transaction.save
          @user.save_with_payment
          #@transaction.payment(@price)
          format.js { render }
        else
          format.html { render action: "new" }
          format.json { render json: @transaction.errors, status: :unprocessable_entity }
        end
      else
        #non-user encountered form and didn't enter password
        if @transaction.save
          begin
            charge = Stripe::Charge.create(
              :amount => @price*100, # amount in cents, again
              :currency => "usd",
              :card => params[:transaction][:stripe_card_token],
              :description => params[:transaction][:email]
            )
          rescue Stripe::CardError => e
            # The card has been declined
          end 
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
