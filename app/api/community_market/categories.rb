class CommunityMarket::Categories < Grape::API
  helpers do
    params :pagination do
      optional :page, type: Integer
      optional :per_page, type: Integer
    end
  end

  resource :categories do
    desc "Return a list of posts", {
      notes: <<-END
        Add a new user with the given name.  Use the resulting auth_token in API calls that require a logged in user.
        In the future, this user can log in again by using the same email and password.

        #### Example response
            { auth_token: "SOME_STRING" }
END
}
  params do
    requires :auth_token, type:String, desc:'Obtain this from the auth API'
    use :pagination
  end
  get '/', http_codes:[
      [200, "400 - Missing required params"]
  ] do

    PostCategory.all()

  end


  end
end
