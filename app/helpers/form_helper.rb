module FormHelper
  def setup_post(post, first_group)
    if signed_in?
      if post.groups
        groups = current_user.groups_as_owner + current_user.groups_as_member 
        (groups - post.groups).each do |group|
          post.assignments.build(:group_id => group.id)
        end
        post.assignments.sort_by {|x| x.group.name }
        # asset = post.assets.build
        post
      else
        post.errors_message("you aren't signed up to any groups")
        post
      end
    else
      # post.assignments.build(:group_id => first_group.id)
      # post.assets.build
      post
    end
  end
end