class CommunityMarket::Auth < Grape::API
  helpers do

  end

  resource :users do
    desc "Return an auth_token for the newly registered user who can login with an email/password", {
      notes: <<-END
        Add a new user with the given name.  Use the resulting auth_token in API calls that require a logged in user.
        In the future, this user can log in again by using the same email and password.

        #### Example response
            { auth_token: "SOME_STRING" }
      END
    }
    params do
      requires :email, type: String, regexp: /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,6}$.?/i, desc:'e.g. oscar@madisononline.com'
      requires :password, type: String, regexp: /.{6,20}/, desc:'6-20 character password'
      requires :name, type: String, desc:"The user's name"
      requires :phone_number, type: String, desc:"The user's phone number"
    end
    post 'register', http_codes:[
        [200, "1002 - A user with that email is already registered"],
        [200, "1009 - Handle is already taken"],
        [200, "400 - Missing required params"]
      ] do

      fail! 1002, "A user with that email is already registered" if User.find_by_email declared_params[:email]

      user = User.create! name:declared_params[:name], email:declared_params[:email], password:declared_params[:password], auth_token:"A"+UUID.new.generate, phone_number:declared_params[:phone_number]

      {auth_token:user.auth_token, email:user.email, name:user.name, phone_number:user.phone_number}
    end

    desc "Return an auth_token for the exising or newly registered user who can login with facebook credentials", {
      notes: <<-END
        Add a new user with the given name.  Use the resulting auth_token in API calls that require a logged in user.
        In the future, this user can log in again by using the same facebook acccount.

        #### Example response
            { auth_token: "SOME_STRING" }
      END
    }
    params do
      requires :email, type: String, regexp: /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,6}$.?/i, desc:'e.g. oscar@madisononline.com'
      requires :name, type: String, desc:"The user's name"
    end
    post 'register_by_facebook', http_codes:[
        [200, "400 - Missing required params"]
      ] do




      user = User.find_by_email declared_params[:email]
      user = User.new name:declared_params[:name], email:declared_params[:email], password:UUID.new.generate unless user

      user.update_attributes! auth_token:"A"+UUID.new.generate
      user.save!


      {auth_token:user.auth_token, email:user.email, name:user.name}
    end


    desc "Return an auth_token for the newly logged in user", {
      notes: <<-END
        This API validates that the email/password match.  If so, the instance gets a new auth_token and any previously obtained auth_token for this instance will become invalid.

        One of email or username is requried.

        #### Example response
            { auth_token: "SOME_STRING", email: "your@address.com", username: "Your Handle" }
      END
    }
    params do
      requires :password, type: String
      requires :email, type: String
    end
    post 'login', http_codes: [
        [200, "1006 - Email not supplied"],
        [200, "1004 - Email not found"],
        [200, "1008 - Wrong password"],
        [200, "400 - Missing required params"]
      ] do

      fail! 1006, "Email not supplied" unless declared_params[:email]
      if declared_params[:email]
        user = User.find_by_email params[:email]
        fail! 1004, "Email not found" unless user
      end

      fail! 1008, "Wrong password" unless user.valid_password? declared_params[:password]

      user.update_attributes auth_token:"A"+UUID.new.generate

      {auth_token:user.auth_token, email:user.email, username:user.name}
    end


    desc "Join or leave a group", {
      notes: <<-END
        Invalidate the auth_token for this instance.  To use the APIs, this instance will need to register or login to obtain a new auth_token.

        #### Example response
            {}
      END
    }
    params do
      requires :auth_token, type:String, desc:'Obtain this from the auth API'
    end
    post 'join_or_leave', http_codes: [
        [200, "400 - Missing required params"]
      ] do
      validate_user!


      group = Group.find params[:id]

      if current_user.joining? group
        current_user.leave! group
      else
        current_user.join! group
      end

      is_member = current_user.joining?(group) ? 1: 0
      {is_member:is_member}
    end

    desc "Follow or unfollow a tag", {
        notes: <<-END
        Invalidate the auth_token for this instance.  To use the APIs, this instance will need to register or login to obtain a new auth_token.

                #### Example response
                    {}
        END
    }
    params do
      requires :auth_token, type:String, desc:'Obtain this from the auth API'
    end
    post 'follow_or_unfollow', http_codes: [
        [200, "400 - Missing required params"]
    ] do
      validate_user!

      tag = Tag.find params[:id]

      if current_user.following? tag
        current_user.unfollow! tag
      else
        current_user.follow! tag
      end

      is_member = current_user.following?(tag) ? 1: 0
      {is_member:is_member}
    end


    desc "Log out the user", {
        notes: <<-END
        Invalidate the auth_token for this instance.  To use the APIs, this instance will need to register or login to obtain a new auth_token.

                #### Example response
                    {}
        END
    }
    params do
      requires :auth_token, type:String, desc:'Obtain this from the auth API'
    end
    post 'logout', http_codes: [
        [200, "400 - Missing required params"]
    ] do
      validate_user!

      current_user.update_attributes auth_token:nil

      {}
    end

    desc "Update the user's profile", {
        notes: <<-END
        Invalidate the auth_token for this instance.  To use the APIs, this instance will need to register or login to obtain a new auth_token.

                #### Example response
                    {}
        END
    }
    params do
      requires :auth_token, type:String, desc:'Obtain this from the auth API'
      requires :name, type:String, desc:'Obtain this from the auth API'
      requires :email, type:String, desc:'Obtain this from the auth API'
    end
    post '/', http_codes: [
        [200, "400 - Missing required params"]
    ] do

      validate_user!

      user = current_user

      user.name = name
      user.email = email




      params[:groups].each do |group_param|
        group = Group.find group_param
        user.groups_as_member << group
      end


      params[:tags].each do |tag_param|
        tag = Tag.find tag_param
        user.followed_tags << tag
      end


      {}
    end

  end
end
