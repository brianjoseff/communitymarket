object false
child @tags, :root => "data", :object_root => false do
    attributes :id, :name
    node :is_member do |tag|
        tag.has_this_user @user
    end
end