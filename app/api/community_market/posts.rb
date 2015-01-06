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

    def send_notification_emails_to_group_members(groups, user)
      all_memberships = []
      for group in @groups do
        Membership.where(:group_id => group.id).each do |membership|
          all_memberships << membership
        end
      end
      all_memberships = all_memberships.uniq
      every_posts = []
      every_posts = all_memberships.select{|membership| membership.email_setting_id == 1}
      no_email_settings = []
      no_email_settings = all_memberships.select{|membership| membership.email_setting_id == nil}
      daily_memberships = []
      daily_memberships = all_memberships.select{|membership| membership.email_setting_id == 2}
      weekly_memberships = []
      weekly_memberships = all_memberships.select{|membership| membership.email_setting_id == 3}
      daily_aggs = []
      daily_aggs = all_memberships.select{|membership| membership.email_setting_id == 4}
      weekly_aggs = []
      weekly_aggs = all_memberships.select{|membership| membership.email_setting_id == 5}
      off = []
      off = all_memberships.select{|membership| membership.email_setting_id == 6}
      #*************************************************************************************

      for every_post in every_posts do
        user = User.find(every_post.member_id)
        NewPostMailer.notify(@user, @post, user, group).deliver
      end
      for daily_membership in daily_memberships do
        user = User.find(daily_membership.member_id)
        group = Group.find(daily_membership.group_id)
        DailyQueue.create(:sender_id => @user.id, :post_id => @post.id, :user_id => user.id, :group_id => group.id)
      end
      for weekly_membership in weekly_memberships do
        user = User.find(weekly_membership.member_id)
        group = Group.find(daily_membership.group_id)
        WeeklyQueue.create(:sender_id => @user.id, :post_id => @post.id, :user_id => user.id, :group_id => group.id)
      end
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


  resource :post do
    desc "Create a post", {
        notes: <<-END
        Add a new user with the given name.  Use the resulting auth_token in API calls that require a logged in user.
                In the future, this user can log in again by using the same email and password.

                #### Example response
                    { auth_token: "SOME_STRING" }
        END
    }
    params do
      requires :auth_token, type:String, desc:'Obtain this from the auth API'
      requires :title, type:String, desc:'Title of the Post'
      requires :post_category_id, type:Integer, desc:'Category ID of the Post'
      # requires :price, type:Integer, desc:'Obtain this from the auth API'

    end
    post '/', http_codes:[
        [200, "400 - Missing required params"],
        [1001, "1001 - Failed to save the post"]
    ] do


      validate_user!

      @user = current_user


      @post = Post.new

      @post.user = @user
      @post.title = params[:title]

      # @post.post_category_id = 1
      @post.post_category = PostCategory.find(params[:post_category_id])

      # @post.price = params[:price]
      @post.premium = false

      params[:groups].each do |group_param|
        group = Group.find group_param
        @post.groups << group
      end

      params[:file].each do |avatar|

        @asset = @post.assets.build
        attachment = {
            :filename => avatar[:filename],
            :type => avatar[:type],
            :headers => avatar[:head],
            :tempfile => avatar[:tempfile]
        }
        @asset.image = ActionDispatch::Http::UploadedFile.new(attachment)
        @asset.save
      end

      if @post.save

        @groups = @post.groups
        # all_members = []
        unless @groups.empty?
          send_notification_emails_to_group_members(@groups, @user)
        end
        @post
      else
        fail! 1001, "Failed to save the post"
      end

    end
  end
end
