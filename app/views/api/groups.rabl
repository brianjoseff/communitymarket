object false
child @groups, :root => "data", :object_root => false do
    attributes :id, :name
    node :is_member do |group|
        group.has_this_user @user
    end
end