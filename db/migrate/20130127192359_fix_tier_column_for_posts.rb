class FixTierColumnForPosts < ActiveRecord::Migration
  def change
    rename_column :posts, :tier, :tier_id
  end
end
