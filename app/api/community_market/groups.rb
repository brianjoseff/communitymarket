class CommunityMarket::Groups < Grape::API

  resource :groups do
    desc "Return a list of random groups", {
      notes: <<-END
        Add a new user with the given name.  Use the resulting auth_token in API calls that require a logged in user.
        In the future, this user can log in again by using the same email and password.

        #### Example response
            { auth_token: "SOME_STRING" }
END
}
    params do
      requires :auth_token, type:String, desc:'Obtain this from the auth API'

    end
    get 'random', rabl: "groups", http_codes:[
        [200, "400 - Missing required params"]
    ] do

      validate_user!

      @user = current_user

      @groups = Group.order("RANDOM()").first(10)

    end

    desc "Return a list of popular groups", {
        notes: <<-END
        Add a new user with the given name.  Use the resulting auth_token in API calls that require a logged in user.
                In the future, this user can log in again by using the same email and password.

                #### Example response
                    { auth_token: "SOME_STRING" }
        END
    }
    params do
      requires :auth_token, type:String, desc:'Obtain this from the auth API'

    end
    get 'popular', rabl: "groups", http_codes:[
        [200, "400 - Missing required params"]
    ] do

      validate_user!

      @user = current_user

      @groups = Group.joins(:memberships).select('groups.*,count(group_id) as "group_count"').group('groups.id').order(' group_count desc').first(10)


    end

  end
end
