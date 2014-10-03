class CommunityMarket::Posts < Grape::API
  helpers do
    params :pagination do
      optional :page, type: Integer
      optional :per_page, type: Integer
    end

    def filter_posts(posts)
      posts = posts.select do |post|
        case
          when post.active?
            true
          when !post.active? && post.completed?
            false
          else
            false
        end
      end
      return posts
    end
  end

  resource :posts do
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
  get '/', rabl: "posts", http_codes:[
      [200, "400 - Missing required params"]
  ] do

    @posts = Post.all.sort { |x,y| y.created_at <=> x.created_at }
    @posts.paginate(page: params[:page],
                    per_page: params[:per_page])

  end


  end
end
