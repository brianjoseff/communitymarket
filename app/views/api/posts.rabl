object false
child @posts, :object_root => false do
    attributes :active, :borrow, :cash, :completed, :borrow, :created_at, :description, :email, :hourly_rate, :id,
                :lump_sum, :other, :post_category_id, :post_to_facebook, :premium, :price, :tier_id, :other,
                :title, :updated_at, :user_id
    node :img_url do |post|
        if post.post_category_id == 1
            post.assets.empty?  ? '/assets/small.png': post.assets.first.image.url(:thumb)
        end
    end
end