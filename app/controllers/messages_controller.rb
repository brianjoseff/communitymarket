class MessagesController < ApplicationController
  before_filter :redirect_to_signup, :only => [:new]
  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messages }
    end
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    @message = Message.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @message }
    end
  end

  # GET /messages/new
  # GET /messages/new.json
  def new
    @message = Message.new
    # @message.post_id = params[:message][:post_id]
    # flash[:the_post_id] = params[:post_id]
    # flash[:seller_email] = params[:recipient]
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @message }
    end
  end

  # GET /messages/1/edit
  def edit
    @message = Message.find(params[:id])
  end

  # POST /messages
  # POST /messages.json
  def create
    @user = current_user
    @message = Message.new(params[:message])
    @message.post_id = params[:message][:post_id]
    @message.sender = @user.email
    @sender = @user.email
    @post = Post.find(@message.post_id)
    respond_to do |format|
      if @message.save
        MessageMailer.send_message(@post, @sender, params[:message][:recipient],params[:message][:subject], params[:message][:content]).deliver
        format.html { redirect_to root_path, notice: 'Message was successfully sent.' }
        format.json { render json: @message, status: :created, location: @message }
      else
        format.html { render action: "new" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /messages/1
  # PUT /messages/1.json
  def update
    @message = Message.find(params[:id])

    respond_to do |format|
      if @message.update_attributes(params[:message])
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to messages_url }
      format.json { head :no_content }
    end
  end

  def store_location
    session[:user_return_to] = request.url
    #session[:return_to] = root_path
    #setting to root here because it redirects to sign up when the user tries to access /followships

  end

end
