class CommunityMarket::Tags < Grape::API

  resource :tags do
    desc "Return a list of random tags", {
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
    get 'random', rabl: "tags", http_codes:[
        [200, "400 - Missing required params"]
    ] do

      validate_user!

      @user = current_user

      @tags = Tag.order("RANDOM()").first(10)


    end

    desc "Return a list of popular tags", {
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
    get 'popular', rabl: "tags", http_codes:[
        [200, "400 - Missing required params"]
    ] do

      validate_user!

      @user = current_user

      @tags = Tag.joins(:taggings).select('tags.*, count(tag_id) as "tag_count"').group('tags.id').order(' tag_count desc').first(10)


    end

  end
end
