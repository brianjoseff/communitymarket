class SessionsController < Devise::SessionsController


  # GET /resource/sign_in
  def new
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    respond_with(resource, serialize_options(resource))
  end

  # POST /resource/sign_in
  # def create
  #    user = User.find_by_email(params[:user][:email].downcase)
  # 
  #    if user && user.valid_password?(params[:user][:password])
  #      set_flash_message(:notice, :signed_in) if is_navigational_format?
  #      sign_in(:user, user)
  #      respond_with user, :location => after_sign_in_path_for(user)
  #    else
  #      flash[:alert] = "Invalid password"
  #      redirect_to new_user_session_path
  #    end
  #  end
  def create
    # Please note that here's no error handling provided in case you'll not find record in database
    @user = User.find_by_email params[:user][:email]
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in_and_redirect @user, :event => :authentication
  end
  

  protected

  def sign_in_params
    devise_parameter_sanitizer.sanitize(:sign_in)
  end

  def serialize_options(resource)
    methods = resource_class.authentication_keys.dup
    methods = methods.keys if methods.is_a?(Hash)
    methods << :password if resource.respond_to?(:password)
    { methods: methods, only: [:password] }
  end

  def auth_options
    { scope: resource_name, recall: "#{controller_path}#new" }
  end

  private

  # Check if there is no signed in user before doing the sign out.
  #
  # If there is no signed in user, it will set the flash message and redirect
  # to the after_sign_out path.
  def verify_signed_out_user
    if all_signed_out?
      set_flash_message :notice, :already_signed_out if is_flashing_format?

      respond_to_on_destroy
    end
  end

  def all_signed_out?
    users = Devise.mappings.keys.map { |s| warden.user(scope: s, run_callbacks: false) }

    users.all?(&:blank?)
  end

  def respond_to_on_destroy
    # We actually need to hardcode this as Rails default responder doesn't
    # support returning empty response on GET request
    respond_to do |format|
      format.all { head :no_content }
      format.any(*navigational_formats) { redirect_to after_sign_out_path_for(resource_name) }
    end
  end
end