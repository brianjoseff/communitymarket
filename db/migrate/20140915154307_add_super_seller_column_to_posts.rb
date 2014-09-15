class AddSuperSellerColumnToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :sseller_post_for_user_id, :integer
    add_column :posts, :sseller_post, :boolean, :default => false
    add_index :posts, :sseller_post_for_user_id
  end
end
