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
    get 'random', http_codes:[
        [200, "400 - Missing required params"]
    ] do

      validate_user!

      @user = current_user

      @random_groups = Group.order("RANDOM()").first(10)
      @random_groups

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
    get 'popular', http_codes:[
        [200, "400 - Missing required params"]
    ] do

      validate_user!

      @user = current_user

      @popular_groups = Group.joins(:memberships).select('groups.*,count(group_id) as "group_count"').group('groups.id').order(' group_count desc').first(10)
      @popular_groups

    end

  end
end
